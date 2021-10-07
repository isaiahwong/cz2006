import 'package:flutter/material.dart';

/// Show a list of results
class SearchResultScreen extends StatelessWidget {
  final List<Widget> widgets;
  SearchResultScreen(this.widgets);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        return Align(alignment: Alignment.centerLeft, child: widgets[index]);
      },
    );
  }
}
