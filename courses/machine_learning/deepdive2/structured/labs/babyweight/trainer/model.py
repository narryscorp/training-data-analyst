import datetime
import os
import shutil
import numpy as np
import tensorflow as tf

# Determine CSV, label, and key columns
CSV_COLUMNS = ["weight_pounds",
               "is_male",
               "mother_age",
               "plurality",
               "gestation_weeks"]
LABEL_COLUMN = "weight_pounds" # TODO: Add CSV_COLUMNS and LABEL_COLUMN

# Set default values for each CSV column.
# Treat is_male and plurality as strings.
DEFAULTS = [[0.0], ["null"], [0.0], ["null"], [0.0]] # TODO: Add DEFAULTS


def features_and_labels(row_data):
    label = row_data.pop(LABEL_COLUMN)

    return row_data, label # TODO: Add your code here
    #pass


def load_dataset(pattern, batch_size=1, mode='eval'):
    print("mode = {}".format(mode))

    dataset = tf.data.experimental.make_csv_dataset(
        file_pattern=pattern,
        batch_size=batch_size,
        column_names=CSV_COLUMNS,
        column_defaults=DEFAULTS)

    # Map dataset to features and label
    dataset = dataset.map(map_func=features_and_labels)  # features, label

    # Shuffle and repeat for training
    if mode == 'train':
        dataset = dataset.shuffle(buffer_size=1000).repeat()

    # Take advantage of multi-threading; 1=AUTOTUNE
    dataset = dataset.prefetch(buffer_size=1)

    return dataset # TODO: Add your code here
    #pass


def create_input_layers():
    deep_inputs = {
        colname: tf.keras.layers.Input(
            name=colname, shape=(), dtype="float32")
        for colname in ["mother_age", "gestation_weeks"]
    }

    wide_inputs = {
        colname: tf.keras.layers.Input(
            name=colname, shape=(), dtype="string")
        for colname in ["is_male", "plurality"]
    }

    inputs = {**wide_inputs, **deep_inputs}

    return inputs # TODO: Add your code here
    #pass


def categorical_fc(name, values):
    cat_column = tf.feature_column.categorical_column_with_vocabulary_list(
            key=name, vocabulary_list=values)
    ind_column = tf.feature_column.indicator_column(
        categorical_column=cat_column)

    return cat_column, ind_column # TODO: Add your code here
    #pass


def create_feature_columns(nembeds):
    deep_fc = {
        colname: tf.feature_column.numeric_column(key=colname)
        for colname in ["mother_age", "gestation_weeks"]
    }
    wide_fc = {}
    is_male, wide_fc["is_male"] = categorical_fc(
        "is_male", ["True", "False", "Unknown"])
    plurality, wide_fc["plurality"] = categorical_fc(
        "plurality", ["Single(1)", "Twins(2)", "Triplets(3)",
                      "Quadruplets(4)", "Quintuplets(5)", "Multiple(2+)"])

    # Bucketize the float fields. This makes them wide
    age_buckets = tf.feature_column.bucketized_column(
        source_column=deep_fc["mother_age"],
        boundaries=np.arange(15, 45, 1).tolist())
    wide_fc["age_buckets"] = tf.feature_column.indicator_column(
        categorical_column=age_buckets)

    gestation_buckets = tf.feature_column.bucketized_column(
        source_column=deep_fc["gestation_weeks"],
        boundaries=np.arange(17, 47, 1).tolist())
    wide_fc["gestation_buckets"] = tf.feature_column.indicator_column(
        categorical_column=gestation_buckets)

    # Cross all the wide columns, have to do the crossing before we one-hot
    crossed = tf.feature_column.crossed_column(
        keys=[age_buckets, gestation_buckets],
        hash_bucket_size=1000)
    deep_fc["crossed_embeds"] = tf.feature_column.embedding_column(
        categorical_column=crossed, dimension=nembeds)

    return wide_fc, deep_fc # TODO: Add your code here
    #pass


def get_model_outputs(wide_inputs, deep_inputs, dnn_hidden_units):
    layers = [int(x) for x in dnn_hidden_units]
    deep = deep_inputs
    for layerno, numnodes in enumerate(layers):
        deep = tf.keras.layers.Dense(
            units=numnodes,
            activation="relu",
            name="dnn_{}".format(layerno+1))(deep)
    deep_out = deep

    # Linear model for the wide side
    wide_out = tf.keras.layers.Dense(
        units=10, activation="relu", name="linear")(wide_inputs)

    # Concatenate the two sides
    both = tf.keras.layers.concatenate(
        inputs=[deep_out, wide_out], name="both")

    # Final output is a linear activation because this is regression
    output = tf.keras.layers.Dense(
        units=1, activation="linear", name="weight")(both)

    return output # TODO: Add your code here
    #pass


def rmse(y_true, y_pred):
    return tf.sqrt(tf.reduce_mean(tf.square(y_pred - y_true))) # TODO: Add your code here
    #pass


def build_wide_deep_model(dnn_hidden_units=[64, 32], nembeds=3):
    # Create input layers
    inputs = create_input_layers()

    # Create feature columns for both wide and deep
    wide_fc, deep_fc = create_feature_columns(nembeds)

    # The constructor for DenseFeatures takes a list of numeric columns
    # The Functional API in Keras requires: LayerConstructor()(inputs)
    wide_inputs = tf.keras.layers.DenseFeatures(
        feature_columns=wide_fc.values(), name="wide_inputs")(inputs)
    deep_inputs = tf.keras.layers.DenseFeatures(
        feature_columns=deep_fc.values(), name="deep_inputs")(inputs)

    # Get output of model given inputs
    output = get_model_outputs(wide_inputs, deep_inputs, dnn_hidden_units)

    # Build model and compile it all together
    model = tf.keras.models.Model(inputs=inputs, outputs=output)
    model.compile(optimizer="adam", loss="mse", metrics=[rmse, "mse"])

    return model # TODO: Add your code here
    #pass


def train_and_evaluate(args):
    model = build_wide_deep_model(args["nnsize"], args["nembeds"])
    print("Here is our Wide-and-Deep architecture so far:\n")
    print(model.summary())

    trainds = load_dataset(
        args["train_data_path"],
        args["batch_size"],
        'train')

    evalds = load_dataset(
        args["eval_data_path"], 1000, 'eval')
    if args["eval_steps"]:
        evalds = evalds.take(count=args["eval_steps"])

    num_batches = args["batch_size"] * args["num_epochs"]
    steps_per_epoch = args["train_examples"] // num_batches

    checkpoint_path = os.path.join(args["output_dir"], "checkpoints/babyweight")
    cp_callback = tf.keras.callbacks.ModelCheckpoint(
        filepath=checkpoint_path, verbose=1, save_weights_only=True)

    history = model.fit(
        trainds,
        validation_data=evalds,
        epochs=args["num_epochs"],
        steps_per_epoch=steps_per_epoch,
        verbose=2,  # 0=silent, 1=progress bar, 2=one line per epoch
        callbacks=[cp_callback])

    EXPORT_PATH = os.path.join(
        args["output_dir"], datetime.datetime.now().strftime("%Y%m%d%H%M%S"))
    tf.saved_model.save(
        obj=model, export_dir=EXPORT_PATH)  # with default serving function
    print("Exported trained model to {}".format(EXPORT_PATH))
