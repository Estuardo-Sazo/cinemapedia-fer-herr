import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreem extends StatelessWidget {
  static const name = 'home-screem';
  const HomeScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayinMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayinMoviesProvider);
    final slideShowMovies = ref.watch(mociesSlideshowProvider);
    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: slideShowMovies),
        MovieHorizotalListview(movies: nowPlayingMovies,title: 'PELI2',subTitle: 'Sub Peli',)
      ],
    );
  }
}
