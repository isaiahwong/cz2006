part of 'coordinates.dart';

class MapWidget extends StatefulWidget {
  final ValueListenable<List<WayPoint>> wayPoints;
  const MapWidget(this.wayPoints);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  _MapWidgetState();
  late MapBoxOptions _options;
  late MapBoxNavigationViewController _mapboxcontroller;
  late ValueListenable<List<WayPoint>> wayPoints;
  Future<void> initialize() async {
    if (!mounted) return;
    _options = MapBoxOptions(
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

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          child: MapBoxNavigationView(
            options: _options,
            onCreated: (MapBoxNavigationViewController controller) async {
              _mapboxcontroller = controller;
              controller.initialize();
            },
          ),
        ),
      ],
    );
  }
}
