import 'package:flutter/material.dart';

class MovieScreem extends StatelessWidget {
  static const name = 'movie-screem';

  final String movieId;

  const MovieScreem({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: $movieId'),
      ),
    );
  }
}
