import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/http.dart' as http;

class P2PVideo extends StatefulWidget {
  const P2PVideo({Key? key}) : super(key: key);

  @override
  _P2PVideoState createState() => _P2PVideoState();
}

class _P2PVideoState extends State<P2PVideo> {
  final _address = Uri.parse(
    'http://192.168.31.109:8080/offer',
  );
  RTCPeerConnection? _peerConnection;
  final _localRenderer = RTCVideoRenderer();

  MediaStream? _localStream;

  RTCDataChannelInit? _dataChannelDict;
  RTCDataChannel? _dataChannel;
  String transformType = "none";

  // MediaStream? _localStream;
  bool _inCalling = false;

  DateTime? _timeStart;

  bool _loading = false;

  void _onTrack(RTCTrackEvent event) {
    if (event.track.kind == "video") {
      _localRenderer.srcObject = event.streams[0];
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

  Future<void> _negotiateRemoteConnection() async {
    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    await _waitForGatheringComplete();

    final des = await _peerConnection!.getLocalDescription();
    final headers = {
      'Content-Type': 'application/json',
    };
    final request = http.Request(
      'POST',
      _address,
    );
    request.body = json.encode(
      {
        "id": "123",
        "topic": "zqGtynZryICLHwM3KKme",
        "sdp": des!.sdp,
        "type": des.type,
        "video_transform": transformType,
      },
    );
    request.headers.addAll(headers);

    final response = await request.send();

    String data = "";
    print(response);
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

  Future<void> _makeCall() async {
    setState(() {
      _loading = true;
    });
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

    final size = MediaQuery.of(context).size;

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
      // _localRenderer.srcObject = _localStream;

      stream.getTracks().forEach((element) {
        _peerConnection!.addTrack(element, stream);
      });

      await _negotiateRemoteConnection();
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    setState(() {
      _inCalling = true;
      _loading = false;
    });
  }

  Future<void> _stopCall() async {
    try {
      // await _localStream?.dispose();
      await _dataChannel?.close();
      await _peerConnection?.close();
      _peerConnection = null;
      _localRenderer.srcObject = null;
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _inCalling = false;
    });
  }

  Future<void> initLocalRenderers() async {
    await _localRenderer.initialize();
  }

  @override
  void initState() {
    super.initState();

    initLocalRenderers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.black,
                          child: _loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      Positioned.fill(
                        child: RTCVideoView(
                          _localRenderer,
                          mirror: false,
                          // mirror: true,
                        ),
                      ),
                      _inCalling
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: _toggleCamera,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.black26,
                                  child: Center(
                                    child: Icon(
                                      Icons.cameraswitch,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                InkWell(
                  onTap: _loading
                      ? () {}
                      : _inCalling
                          ? _stopCall
                          : _makeCall,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _loading
                          ? Colors.amber
                          : _inCalling
                              ? Colors.red
                              : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: _loading
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              _inCalling ? "STOP" : "START",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
