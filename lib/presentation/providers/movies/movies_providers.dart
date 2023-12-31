import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_respository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayinMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fecthMoreMovies = ref.watch(movieRepostoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fecthMoreMovies);
});


final popuparMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fecthMoreMovies = ref.watch(movieRepostoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fecthMoreMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fecthMoreMovies = ref.watch(movieRepostoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fecthMoreMovies);
});


final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fecthMoreMovies = ref.watch(movieRepostoryProvider).getUpcoming;
  return MoviesNotifier(fetchMoreMovies: fecthMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if(isLoading)return;

    isLoading= true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    isLoading = false;
  }
}
