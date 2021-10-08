import 'package:fitness/repo/cycling/coordinates_model.dart';

abstract class CoordinatesDelegate {
  Map<String, Coordinates> coordinates = {};
  void onCoordinatesSelected(Coordinates c);
  void onCoordinatesRemoved(Coordinates c);
  void onCoordinatesChanged(Coordinates c);
  bool coordsExists(Coordinates c);
  bool coordsNotExists(Coordinates c);
  void onCoordinatesSelectionDone();
}
