	33333��?33333��?!33333��?	zC��*@zC��*@!zC��*@"e
=type.googleapis.com/tensorflow.profiler.PerGenericStepDetails$33333��?��,���?A�n��om�?Yd#���?*	J+���@2�
yIterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Map::BatchV2::ShuffleAndRepeat::LegacyParallelInterleaveV2[0]::CSV"�	�c�?!��f4�I=@)�	�c�?1��f4�I=@:Preprocessing2�
qIterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Map::BatchV2::ShuffleAndRepeat::LegacyParallelInterleaveV2 �,��o��?!A��\��4@)�,��o��?1A��\��4@:Preprocessing2z
CIterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Map::BatchV2��!6X8�?!�1Q��K@)�.��[<�?1ĝ�x2@:Preprocessing2�
UIterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Map::BatchV2::ShuffleAndRepeat �^Ӄ�R�?!�b�S��B@)ѐ�(��?1j6J.P0@:Preprocessing2b
+Iterator::Model::Prefetch::ShuffleAndRepeat{3j�J>�?!�pu�C�#@)�̕A���?1[ov�� @:Preprocessing2P
Iterator::Model::Prefetch �d�F �?!��o��@) �d�F �?1��o��@:Preprocessing2F
Iterator::Model@j'��?!c����J@) �o_Ή?1@�2�� @:Preprocessing2l
5Iterator::Model::Prefetch::ShuffleAndRepeat::PrefetchԛQ�U�?!��2�Xz�?)ԛQ�U�?1��2�Xz�?:Preprocessing2q
:Iterator::Model::Prefetch::ShuffleAndRepeat::Prefetch::Mapx_���?!�/_r�L@)��\5�q?1m��dL�?:Preprocessing:�
]Enqueuing data: you may want to combine small input data chunks into fewer but larger chunks.
�Data preprocessing: you may increase num_parallel_calls in <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#map" target="_blank">Dataset map()</a> or preprocess the data OFFLINE.
�Reading data from files in advance: you may tune parameters in the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch size</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave cycle_length</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer_size</a>)
�Reading data from files on demand: you should read data IN ADVANCE using the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer</a>)
�Other data reading or processing: you may consider using the <a href="https://www.tensorflow.org/programmers_guide/datasets" target="_blank">tf.data API</a> (if you are not using it now)�
:type.googleapis.com/tensorflow.profiler.BottleneckAnalysis�
both�Your program is MODERATELY input-bound because 5.0% of the total step time sampled is waiting for input. Therefore, you would need to reduce both the input time and other time.no*high2t33.7 % of the total step time sampled is spent on 'All Others' time. This could be due to Python execution overhead.9zC��*@>Look at Section 3 for the breakdown of input time on the host.B�
@type.googleapis.com/tensorflow.profiler.GenericStepTimeBreakdown�
	��,���?��,���?!��,���?      ��!       "      ��!       *      ��!       2	�n��om�?�n��om�?!�n��om�?:      ��!       B      ��!       J	d#���?d#���?!d#���?R      ��!       Z	d#���?d#���?!d#���?JCPU_ONLYYzC��*@b 