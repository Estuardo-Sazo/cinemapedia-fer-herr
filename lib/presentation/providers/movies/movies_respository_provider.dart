
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cinemapedia/infrastructure/datasource/moviedb_datasource.dart';

final movieRepostoryProvider = Provider((ref) {
  return MovieRepositoryImpl(datasource: MoviedbDatasource());
});
