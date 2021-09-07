import 'package:fitness/app/components/panel/panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryScreen extends StatelessWidget {
  FullScreenPanelController controller = FullScreenPanelController.to();

  static Widget Screen() {
    return FullScreenPanel(
      body: SecondaryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[40],
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            controller.open();
          },
          child: Text("Next screen"),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Secondary Screen"),
    );
  }
}
