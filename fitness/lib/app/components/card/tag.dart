import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String title;
  const Tag({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: boxShadow.copyWith(
            borderRadius: BorderRadius.circular(5),
            color: accentColor,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 150),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // Positioned(
        //   left: -8,
        //   top: -10,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     child: Icon(
        //       CupertinoIcons.minus_circle,
        //       color: red,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
