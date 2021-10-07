import 'package:fitness/repo/cycling/coordinates_model.dart';

abstract class CoordinatesDelegate {
  Map<String, Coordinates> coordinates = {};
  void onCoordinatesSelected(Coordinates coordinates);
  void onCoordinatesRemoved(Coordinates coordinates);
  void onCoordinatesChanged(Coordinates coordinates);
  bool exists(Coordinates coordinates);
  bool notExists(Coordinates coordinates);
  void onCoordinatesSelectionDone();
}
