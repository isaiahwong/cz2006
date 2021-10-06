import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/screens/workout/hiit/active/pose/pose_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PoseScreen extends GetView<PoseController> {
  PoseScreen({Key? key}) : super(key: key);

  Widget stage() {
    if (controller.loading)
      return Container(child: Center(child: CircularProgressIndicator()));
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<PoseController>(builder: (context) {
        return Container(
          child: Stack(
            children: [
              stage(),
              Positioned.fill(
                child: RTCVideoView(
                  controller.localRenderer,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  filterQuality: FilterQuality.high,
                  mirror: true,
                  // mirror: true,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
