import 'package:fitness/app/screens/cycling/coordinates_delegate.dart';
import 'package:fitness/repo/cycling/coordinates_model.dart';
import 'package:fitness/repo/cycling/coordinates_repo.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:get/get.dart';

class CoordinatesController extends GetxController {
  late final CoordinatesRepo coordinatesRepo;
  late CoordinatesDelegate delegateController;
  late MapBoxOptions mapboxOptions;
  late MapBoxNavigationViewController mapboxController;

  List<Coordinates> filteredCoordinates = [];

  List<Coordinates> coordinates = [];

  factory CoordinatesController.to() {
    return Get.find();
  }

  CoordinatesController({
    CoordinatesRepo? coordinatesRepo,
    required this.delegateController,
    List<Coordinates>? selected,
  }) {
    this.coordinatesRepo =
        coordinatesRepo == null ? Get.find() : CoordinatesRepo();
  }

  @override
  void onInit() async {
    super.onInit();
    initMapBoxOptions();
    coordinates = await coordinatesRepo.getCoordinates();
    coordinates = List.from(coordinates)
      ..map((e) => delegateController.coordsExists(e)
          ? delegateController.coordinates[e.id]
          : e);
    filteredCoordinates = List.from(coordinates);
    update();
  }

  initMapBoxOptions() {
    mapboxOptions = MapBoxOptions(
      //initialLatitude: 1.3521,
      //initialLongitude: 103.8198,
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
      animateBuildRoute: true,
      longPressDestinationEnabled: false,
      language: "en",
    );
  }

  void setMapBoxController(MapBoxNavigationViewController controller) {
    this.mapboxController = controller;
    this.mapboxController.initialize();
    update();
  }

  bool isSelected(Coordinates c) {
    return delegateController.coordsExists(c);
  }

  void onFilter(String query) {
    /// Returns all items if query is empty
    if (query.isEmpty) {
      filteredCoordinates = List.from(coordinates);
      update();
      return;
    }
    filteredCoordinates = List<Coordinates>.from(coordinates)
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  Coordinates? onStartSelected(Coordinates c) {
    if (isSelected(c)) return delegateController.coordinates[c.id];
    delegateController.onCoordinatesSelected(c);

    mapboxController.buildRoute(
      wayPoints: [
        WayPoint(
          name: c.name,
          latitude: c.x,
          longitude: c.y,
        ),
        WayPoint(
          name: c.name,
          latitude: c.x,
          longitude: c.y,
        ),
      ],
    );
    update();
    return c;
  }

  Coordinates? onDestinationSelected(Coordinates c) {
    if (isSelected(c)) return delegateController.coordinates[c.id];
    delegateController.onCoordinatesSelected(c);

    mapboxController.buildRoute(
      wayPoints: [
        WayPoint(
          name: c.name,
          latitude: c.x,
          longitude: c.y,
        ),
      ],
    );
    update();
    return c;
  }

  void onRemove(Coordinates c) {
    if (!isSelected(c)) return;
    delegateController.onCoordinatesRemoved(c);
    update();
  }
}
