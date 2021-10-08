import 'dart:async';
import 'dart:convert';

import 'package:fitness/repo/exercise/model.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' as _;

class PoseController extends _.GetxController {
  static PoseController get() => _.Get.find();

  final _address = Uri.parse(
    'http://192.168.31.109:8080/offer',
  );
  RTCPeerConnection? _peerConnection;
  final localRenderer = RTCVideoRenderer();

  MediaStream? _localStream;

  RTCDataChannelInit? _dataChannelDict;
  RTCDataChannel? _dataChannel;
  String transformType = "none";

  // MediaStream? _localStream;
  bool started = false;

  DateTime? _timeStart;

  bool loading = false;

  Future<void> initLocalRenderers() async {
    await localRenderer.initialize();
  }

  @override
  void onInit() async {
    super.onInit();
    await initLocalRenderers();
  }

  void _onTrack(RTCTrackEvent event) {
    if (event.track.kind == "video") {
      localRenderer.srcObject = event.streams[0];
    }
  }

  void _onDataChannelState(RTCDataChannelState? state) {
    switch (state) {
      case RTCDataChannelState.RTCDataChannelClosed:
        break;
      case RTCDataChannelState.RTCDataChannelOpen:
        break;
      default:
        print("Data Channel State: $state");
    }
  }

  Future<bool> _waitForGatheringComplete() async {
    if (_peerConnection!.iceGatheringState ==
        RTCIceGatheringState.RTCIceGatheringStateComplete) {
      return true;
    } else {
      await Future.delayed(Duration(seconds: 1));
      return await _waitForGatheringComplete();
    }
  }

  void _toggleCamera() async {
    if (_localStream == null) throw Exception('Stream is not initialized');

    final videoTrack = _localStream!
        .getVideoTracks()
        .firstWhere((track) => track.kind == 'video');
    await Helper.switchCamera(videoTrack);
  }

  Future<void> _negotiateRemoteConnection(Map<String, dynamic> body) async {
    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    await _waitForGatheringComplete();

    final headers = {
      'Content-Type': 'application/json',
    };
    final request = http.Request(
      'POST',
      _address,
    );
    final des = await _peerConnection!.getLocalDescription();
    body["sdp"] = des!.sdp;
    body["type"] = des.type;
    body["video_transform"] = transformType;
    request.body = json.encode(body);
    request.headers.addAll(headers);

    final response = await request.send();

    String data = "";
    if (response.statusCode == 200) {
      data = await response.stream.bytesToString();
      var dataMap = json.decode(data);
      print(dataMap);
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(
          dataMap["sdp"],
          dataMap["type"],
        ),
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> makeCall({
    required Exercise exercise,
    required User user,
    required RoutineInterval interval,
  }) async {
    loading = true;
    var configuration = <String, dynamic>{
      'sdpSemantics': 'unified-plan',
    };

    // Create Peer Connection
    if (_peerConnection != null) return;
    _peerConnection = await createPeerConnection(
      configuration,
    );

    _peerConnection!.onTrack = _onTrack;

    // Create Data Channel
    _dataChannelDict = RTCDataChannelInit();
    _dataChannelDict!.ordered = true;
    _dataChannel = await _peerConnection!.createDataChannel(
      "chat",
      _dataChannelDict!,
    );
    _dataChannel!.onDataChannelState = _onDataChannelState;
    // _dataChannel!.onMessage = _onDataChannelMessage;

    final mediaConstraints = <String, dynamic>{
      'audio': false,
      'video': {
        'mandatory': {
          'minWidth': 720,
          'minHeight': 1280,
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    try {
      final stream =
          await navigator.mediaDevices.getUserMedia(mediaConstraints);
      // _mediaDevicesList = await navigator.mediaDevices.enumerateDevices();
      _localStream = stream;
      // localRenderer.srcObject = _localStream;

      stream.getTracks().forEach((element) {
        _peerConnection!.addTrack(element, stream);
      });

      final body = {
        "id": user.id,
        "exercise": exercise.id,
        "interval": interval.id,
      };

      await _negotiateRemoteConnection(body);
    } catch (e) {
      print(e.toString());
    }

    started = true;
    loading = false;
    update();
  }

  Future<void> stopCall() async {
    if (!started) return;
    try {
      // await _localStream?.dispose();
      await _dataChannel?.close();
      await _peerConnection?.close();
      _peerConnection = null;
      localRenderer.srcObject = null;
    } catch (e) {
      print(e.toString());
    }
    started = false;
    loading = false;
    update();
  }
}
