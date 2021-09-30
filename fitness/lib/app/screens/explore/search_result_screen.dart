import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  final List<Widget> widgets;
  SearchResultScreen(this.widgets);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (index, context) {
        return Container(
          child: Text("Widget"),
        );
      },
    );
  }
}
