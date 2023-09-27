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
      bottomNavigationBar: const CustomBottomNavigation(),
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
    ref.read(popuparMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(mociesSlideshowProvider);

    final nowPlayingMovies = ref.watch(nowPlayinMoviesProvider);
    final popuparMovies = ref.watch(popuparMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          titlePadding: EdgeInsets.all(0),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // const CustomAppbar(),
            MoviesSlideshow(movies: slideShowMovies),
            MovieHorizotalListview(
              movies: nowPlayingMovies,
              title: 'En Cines',
              subTitle: 'Lunes 20',
              loadNextPage: () =>
                  ref.read(nowPlayinMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizotalListview(
              movies: popuparMovies,
              title: 'Populares',
              subTitle: 'Este mes',
              loadNextPage: () =>
                  ref.read(popuparMoviesProvider.notifier).loadNextPage(),
            ),

            MovieHorizotalListview(
              movies: upcomingMovies,
              title: 'Próximamente',
              subTitle: 'Este mes',
              loadNextPage: () =>
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
            ),

            MovieHorizotalListview(
              movies: topRatedMovies,
              title: 'Mas Populares',
              subTitle: 'Este mes',
              loadNextPage: () =>
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(height: 10),
          ],
        );
      }, childCount: 1))
    ]);
  }
}
