import 'package:fitness/app/components/image/image.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: logoIcon,
              width: 50,
            ),
            SizedBox(width: 10),
            Text(
              "SoFit",
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
