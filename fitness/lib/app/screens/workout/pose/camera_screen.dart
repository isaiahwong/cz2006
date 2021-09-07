import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  RTCPeerConnection? _peerConnection;
  final _localRenderer = RTCVideoRenderer();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
