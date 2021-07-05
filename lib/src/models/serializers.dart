import 'package:built_value/serializer.dart';
import 'package:tema_yts/src/models/movie.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[
  Movie,
])
Serializers serializers =
    (_$serializers.toBuilder().addPlugin(StandardJsonPlugin())).build();
