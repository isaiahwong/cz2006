import 'package:fitness/app/screens/cycling/coordinates_delegate.dart';
import 'package:fitness/repo/cycling/coordinates.dart';
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
      ..map((e) => delegateController.exists(e)
          ? delegateController.coordinates[e.id]
          : e);
    filteredCoordinates = List.from(coordinates);
    update();
  }

  bool isSelected(Coordinates coordinates) {
    return delegateController.exists(coordinates);
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

  Coordinates? onSelected(Coordinates coordinates) {
    if (isSelected(coordinates))
      return delegateController.coordinates[coordinates.id];
    delegateController.onCoordinatesSelected(coordinates);
    update();
    return coordinates;
  }

  void onRemove(Coordinates coordinates) {
    if (!isSelected(coordinates)) return;
    delegateController.onCoordinatesRemoved(coordinates);
    update();
  }
}
