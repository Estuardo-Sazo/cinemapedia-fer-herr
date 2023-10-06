import 'package:flutter/material.dart';

class MovieScreem extends StatefulWidget {
  static const name = 'movie-screem';

  final String movieId;

  const MovieScreem({super.key, required this.movieId});

  @override
  State<MovieScreem> createState() => _MovieScreemState();
}

class _MovieScreemState extends State<MovieScreem> {

  @override
  void initState() {
    super.initState();
    
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: ${widget.movieId}'),
      ),
    );
  }
}
