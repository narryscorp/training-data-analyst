�	�/עh@�/עh@!�/עh@	�
���@�
���@!�
���@"e
=type.googleapis.com/tensorflow.profiler.PerGenericStepDetails$�/עh@�]P߲�?A��j�	��?Y߿yq�?*	���M�,�@2�
qIterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Map::BatchV2::ShuffleAndRepeat::LegacyParallelInterleaveV2 �V
�\b�?!]���{�D@)�V
�\b�?1]���{�D@:Preprocessing2l
5Iterator::Model::Prefetch::ShuffleAndRepeat::Prefetch?#K��?!"��<@)?#K��?1"��<@:Preprocessing2�
yIterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Map::BatchV2::ShuffleAndRepeat::LegacyParallelInterleaveV2[0]::CSV �`�
�+�?!ت�)%"@)�`�
�+�?1ت�)%"@:Preprocessing2z
CIterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Map::BatchV2*���P�?!��L�D>L@)��l��?1�b.�%� @:Preprocessing2�
UIterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Map::BatchV2::ShuffleAndRepeat ک��`��?!"f�e;H@)�L�n�?1,����@:Preprocessing2b
+Iterator::Model::Prefetch::ShuffleAndRepeat��3.�?!��<8�_?@)�u�X��?1{�T��
@:Preprocessing2F
Iterator::Model��\��?!�C&�@):w�^�"�?1fڡ��E�?:Preprocessing2P
Iterator::Model::Prefetch�VBwI��?!ެ��s��?)�VBwI��?1ެ��s��?:Preprocessing2q
:Iterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Map���e+�?!�TM7uL@)&6׆��?1,s�Ay�?:Preprocessing:�
]Enqueuing data: you may want to combine small input data chunks into fewer but larger chunks.
�Data preprocessing: you may increase num_parallel_calls in <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#map" target="_blank">Dataset map()</a> or preprocess the data OFFLINE.
�Reading data from files in advance: you may tune parameters in the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch size</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave cycle_length</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer_size</a>)
�Reading data from files on demand: you should read data IN ADVANCE using the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer</a>)
�Other data reading or processing: you may consider using the <a href="https://www.tensorflow.org/programmers_guide/datasets" target="_blank">tf.data API</a> (if you are not using it now)�
:type.googleapis.com/tensorflow.profiler.BottleneckAnalysis�
both�Your program is POTENTIALLY input-bound because 63.6% of the total step time sampled is spent on 'All Others' time (which could be due to I/O or Python execution or both).no*no9�
���@>Look at Section 3 for the breakdown of input time on the host.B�
@type.googleapis.com/tensorflow.profiler.GenericStepTimeBreakdown�
	�]P߲�?�]P߲�?!�]P߲�?      ��!       "      ��!       *      ��!       2	��j�	��?��j�	��?!��j�	��?:      ��!       B      ��!       J	߿yq�?߿yq�?!߿yq�?R      ��!       Z	߿yq�?߿yq�?!߿yq�?JCPU_ONLYY�
���@b Y      Y@q_fH��>0@"�
both�Your program is POTENTIALLY input-bound because 63.6% of the total step time sampled is spent on 'All Others' time (which could be due to I/O or Python execution or both).b
`input_pipeline_analyzer (especially Section 3 for the breakdown of input operations on the Host)m
ktrace_viewer (look at the activities on the timeline of each Host Thread near the bottom of the trace view)"T
Rtensorflow_stats (identify the time-consuming operations executed on the CPU_ONLY)"Z
Xtrace_viewer (look at the activities on the timeline of each CPU_ONLY in the trace view)*�
�<a href="https://www.tensorflow.org/guide/data_performance_analysis" target="_blank">Analyze tf.data performance with the TF Profiler</a>*y
w<a href="https://www.tensorflow.org/guide/data_performance" target="_blank">Better performance with the tf.data API</a>2I
=type.googleapis.com/tensorflow.profiler.GenericRecommendation
nono:
Refer to the TF2 Profiler FAQb�16.2457% of Op time on the host used eager execution. Performance could be improved with <a href="https://www.tensorflow.org/guide/function" target="_blank">tf.function.</a>2"CPU: B 