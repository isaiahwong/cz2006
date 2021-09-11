import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'card.dart';

class MetricCard extends StatelessWidget {
  final double height;
  final String title;
  final String text;
  final String inlineText;

  const MetricCard({
    Key? key,
    this.height = 70,
    this.title = "Title",
    this.text = "Text",
    this.inlineText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                ),
                Row(
                  children: [
                    Text(
                      text,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      inlineText,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: boxShadow,
    );
  }
}
