part of 'coordinates.dart';

class MapWidget extends GetView<CoordinatesController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<CoordinatesController>(
          builder: (_) => Container(
            height: 200,
            child: MapBoxNavigationView(
              options: controller.mapboxOptions,
              onCreated: (MapBoxNavigationViewController mapboxController) =>
                  controller.setMapBoxController(mapboxController),
            ),
          ),
        ),
      ],
    );
  }
}
