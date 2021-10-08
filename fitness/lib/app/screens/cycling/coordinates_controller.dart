import 'package:fitness/app/screens/cycling/coordinates_delegate.dart';
import 'package:fitness/repo/cycling/coordinates_model.dart';
import 'package:fitness/repo/cycling/coordinates_repo.dart';
import 'package:get/get.dart';

class CoordinatesController extends GetxController {
  late final CoordinatesRepo coordinatesRepo;
  late CoordinatesDelegate delegateController;

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
    coordinates = await coordinatesRepo.getCoordinates();
    coordinates = List.from(coordinates)
      ..map((e) => delegateController.coordsExists(e)
          ? delegateController.coordinates[e.id]
          : e);
    filteredCoordinates = List.from(coordinates);
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

  Coordinates? onSelected(Coordinates c) {
    if (isSelected(c)) return delegateController.coordinates[c.id];
    delegateController.onCoordinatesSelected(c);
    update();
    return c;
  }

  void onRemove(Coordinates c) {
    if (!isSelected(c)) return;
    delegateController.onCoordinatesRemoved(c);
    update();
  }
}
