import 'dart:async';

import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/screens/workout/room/waiting_room_controller.dart';
import 'package:fitness/repo/cycling/course/course.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:fitness/app/screens/cycling/coordinates.dart';
import 'package:fitness/repo/cycling/coordinates_model.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:get/get.dart';

class CyclingDetailsController extends GetxController with CoordinatesDelegate {
  late Cycling cycling;
  final SlidingPanelController panelController;
  final WorkoutRepo workoutRepo = WorkoutRepo.get();
  late final StreamSubscription keyboardSub;
  late final TextEditingController cyclingNameController;
  bool editing = false;
  late MapBoxOptions mapboxOptions;
  late MapBoxNavigationViewController mapboxController;
  late MapBoxNavigation directions;
  late double _distanceRemaining, _durationRemaining;
  late bool _isNavigating = false;
  String _instruction = "";
  late bool _routeBuilt = false;

  @override
  Map<String, Coordinates> coordinates = {};

  CyclingDetailsController({SlidingPanelController? panelController})
      : this.panelController = panelController == null
            ? SlidingPanelController.get(RoutePaths.CYCLING_DETAILS)
            : panelController;

  @override
  void onInit() {
    super.onInit();
    cycling = Get.arguments;
    directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    initMapBoxOptions();
    cyclingNameController = TextEditingController(text: cycling.name);
    keyboardSub =
        KeyboardVisibilityController().onChange.listen(onKeyboardDismiss);
  }

  initMapBoxOptions() {
    mapboxOptions = MapBoxOptions(
      zoom: 14.0,
      tilt: 0.0,
      bearing: 0.0,
      enableRefresh: false,
      alternatives: true,
      voiceInstructionsEnabled: true,
      bannerInstructionsEnabled: true,
      allowsUTurnAtWayPoints: true,
      mode: MapBoxNavigationMode.cycling,
      units: VoiceUnits.metric,
      simulateRoute: false,
      mapStyleUrlDay: "mapbox://styles/zerotoxicity/cktzynfhd0zqh17phrqp14hyl",
      mapStyleUrlNight:
          "mapbox://styles/zerotoxicity/cktzynfhd0zqh17phrqp14hyl",
      animateBuildRoute: false,
      longPressDestinationEnabled: false,
      language: "en",
    );
  }

  void setMapBoxController(MapBoxNavigationViewController controller) {
    this.mapboxController = controller;
    this.mapboxController.initialize();
    update();
    buildRoute();
  }

  @override
  void onClose() {
    keyboardSub.cancel();
    super.onClose();
  }

  void onKeyboardDismiss(bool visible) async {
    if (visible) return;
    cycling = cycling.copyWith(name: cyclingNameController.text.trimRight());
    await workoutRepo.updateCycling(cycling);
    editing = false;
    update();
  }

  void onEdit(String _) {
    editing = true;
    update();
  }

  void buildRoute() {
    var wayPoints = <WayPoint>[];
    for (Course c in cycling.course) {
      wayPoints.add(WayPoint(
          name: c.coordinates.name,
          latitude: c.coordinates.x,
          longitude: c.coordinates.y));
    }
    mapboxController.buildRoute(wayPoints: wayPoints);
  }

  void onCyclingStart() {
    Get.toNamed(RoutePaths.HIIT_WAITING_ROOM, arguments: [
      WaitingRoomType.HOST,
      cycling.copyWith(),
      cycling.type,
    ]);
  }

  void startNavigation() async {
    var wayPoints = <WayPoint>[];
    for (Course c in cycling.course) {
      wayPoints.add(WayPoint(
          name: c.coordinates.name,
          latitude: c.coordinates.x,
          longitude: c.coordinates.y));
    }
    await directions.startNavigation(
        wayPoints: wayPoints,
        options: MapBoxOptions(
            alternatives: true,
            mapStyleUrlDay:
                "mapbox://styles/zerotoxicity/cktzynfhd0zqh17phrqp14hyl",
            mapStyleUrlNight:
                "mapbox://styles/zerotoxicity/cktzynfhd0zqh17phrqp14hyl",
            initialLatitude: wayPoints[0].latitude,
            initialLongitude: wayPoints[0].longitude,
            mode: MapBoxNavigationMode.cycling,
            simulateRoute: false,
            language: "en",
            units: VoiceUnits.metric));
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await directions.distanceRemaining;
    _durationRemaining = await directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction!;
        break;

      case MapBoxEvent.on_arrival:
        await Future.delayed(Duration(seconds: 3));
        await mapboxController.finishNavigation();
        break;

      default:
        break;
    }
  }

  @override
  bool coordsExists(Coordinates c) {
    // TODO: implement coordsExists
    throw UnimplementedError();
  }

  @override
  bool coordsNotExists(Coordinates c) {
    // TODO: implement coordsNotExists
    throw UnimplementedError();
  }

  @override
  void onCoordinatesChanged(Coordinates c) {
    // TODO: implement onCoordinatesChanged
  }

  @override
  void onCoordinatesRemoved(Coordinates c) {
    // TODO: implement onCoordinatesRemoved
  }

  @override
  void onCoordinatesSelected(Coordinates c) {
    // TODO: implement onCoordinatesSelected
  }

  @override
  void onCoordinatesSelectionDone() {
    // TODO: implement onCoordinatesSelectionDone
  }
}
