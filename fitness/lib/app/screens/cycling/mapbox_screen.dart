part of 'coordinates.dart';

const String ACCESS_TOKEN =
    "pk.eyJ1IjoiemVyb3RveGljaXR5IiwiYSI6ImNrdHpmbGl4OTA3cHoydnFndHFpN24wbXcifQ.99WUyaAUQulHdM8Fs7NGMw";

class MapWidget extends StatefulWidget {
  const MapWidget();

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  _MapWidgetState();

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(1.3521, 103.8198),
    zoom: 11.0,
  );

  MapboxMapController? mapController;
  CameraPosition? _position = _kInitialPosition;
  bool _isMoving = false;
  CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  MinMaxZoomPreference _minMaxZoomPreference = MinMaxZoomPreference.unbounded;

  List<String> _styleStrings = [
    MapboxStyles.MAPBOX_STREETS,
    MapboxStyles.SATELLITE,
    "assets/style.json"
  ];
  bool _myLocationEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  void _onMapChanged() {
    setState(() {
      _extractMapInfo();
    });
  }

  void _extractMapInfo() {
    _position = mapController!.cameraPosition;
    _isMoving = mapController!.isCameraMoving;
  }

  @override
  Widget build(BuildContext context) {
    final MapboxMap mapboxMap = MapboxMap(
      accessToken: ACCESS_TOKEN,
      onMapCreated: onMapCreated,
      initialCameraPosition: _kInitialPosition,
      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
      myLocationRenderMode: MyLocationRenderMode.GPS,
      myLocationEnabled: _myLocationEnabled,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
    );
    return Column(
      children: [
        SizedBox(
          height: 200.0,
          child: mapboxMap,
        ),
      ],
    );
  }

  void onMapCreated(MapboxMapController controller) {
    mapController = controller;
    mapController!.addListener(_onMapChanged);
    _extractMapInfo();
  }
}
