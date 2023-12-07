import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovie;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovie,
  });

  void closeStreams() {
    debouncedMovies.close();
    _debounceTimer?.cancel();
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }
      final movies = await searchMovie(query);
      debouncedMovies.add(movies);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar pelicula';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        FadeIn(
          child: IconButton(
            onPressed: () {
              query = '';
            },
            icon: const Icon(Icons.clear),
          ),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        closeStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Buils Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Busca una pelicula'),
      );
    }

    _onQueryChanged(query);
    return StreamBuilder(
      //future: searchMovie(query),
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error al buscar'),
          );
        }
        if (snapshot.hasData) {
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) => _MovieItem(
              movie: movies[index],
              onMiveSelected: (context,movie){
                closeStreams();
                close(context, movie);
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMiveSelected;
  const _MovieItem({
    required this.movie,
    required this.onMiveSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMiveSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //Image
            FadeInLeft(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...',
                          style: textStyle.bodySmall)
                      : Text(movie.overview, style: textStyle.bodySmall),
                  Row(children: [
                    Icon(Icons.star_half_rounded,
                        color: Colors.yellow.shade800),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(HumanFormats.number(movie.voteAverage, 1),
                        style: textStyle.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900))
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
