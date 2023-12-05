import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return const [Text('Buils Actions')];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const Text('Buils Leading');
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Buils Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return const Text('Buils Search Suggestions');
  }
}
