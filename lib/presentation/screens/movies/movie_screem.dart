import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreem extends ConsumerStatefulWidget {
  static const name = 'movie-screem';

  final String movieId;

  const MovieScreem({super.key, required this.movieId});

  @override
  MovieScreemState createState() => MovieScreemState();
}

class MovieScreemState extends ConsumerState<MovieScreem> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body:  Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: ${widget.movieId}'),
      ),
    );
  }
}
