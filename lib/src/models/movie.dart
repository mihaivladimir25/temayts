library movie;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tema_yts/src/models/serializers.dart';

part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {
  factory Movie([void Function(MovieBuilder) updates]) = _$Movie;

  factory Movie.fromJson(dynamic json) {
    return serializers.deserializeWith(serializer, json) as Movie;
  }

  Movie._();

  int get id;

  String get title;

  @BuiltValueField(wireName: 'medium_cover_image')
  String get image;

  static Serializer<Movie> get serializer => _$movieSerializer;
}