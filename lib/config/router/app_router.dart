import 'package:cinemapedia/presentation/screens/screem.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreem.name,
    builder: (context, state) => const HomeScreem(),
  ),
]);
