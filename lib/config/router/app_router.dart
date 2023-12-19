import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screem.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
        builder: (context, state, child) {
          return HomeScreem(childView: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: MovieScreem.name,
                builder: (context, state) {
                  final movieId = state.pathParameters['id'] ?? 'no-id';
                  return MovieScreem(
                    movieId: movieId,
                  );
                },
              )
            ],
            
          ),
          GoRoute(
              path: '/favorite',
              builder: (context, state) => const FavoriteView()),
        ])

    /* GoRoute(
      path: '/',
      name: HomeScreem.name,
      builder: (context, state) => const HomeScreem(
            childView: FavoriteView(),
          ),
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreem.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreem(
              movieId: movieId,
            );
          },
        )
      ]), */
  ],
);
