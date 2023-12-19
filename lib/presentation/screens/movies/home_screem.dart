import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreem extends StatelessWidget {
  static const name = 'home-screem';
  final Widget childView;

  const HomeScreem({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  childView,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
