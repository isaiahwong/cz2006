import 'package:flutter/material.dart';

class SlideIndicator extends StatelessWidget {
  const SlideIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
          ),
        ],
      ),
    );
  }
}
