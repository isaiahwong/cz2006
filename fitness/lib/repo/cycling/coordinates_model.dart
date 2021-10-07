import 'package:json_annotation/json_annotation.dart';

part 'coordinates_model.g.dart';

@JsonSerializable()
class Coordinates {
  static List<Coordinates> fromJsonArray(List? list) {
    if (list == null) return [];
    return List<Map<String, dynamic>>.from(list)
        .map<Coordinates>((e) => Coordinates.fromJson(e))
        .toList();
  }

  final String id;
  final String name;
  final double x;
  final double y;

  Coordinates({
    required this.id,
    required this.name,
    required this.x,
    required this.y,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

  String get getID {
    return id;
  }

  String get getName {
    return name;
  }

  double get getX {
    return x;
  }

  double get getY {
    return y;
  }

  Coordinates copyWith({
    String? name,
    double? x,
    double? y,
  }) {
    return Coordinates(
      id: id ?? this.id,
      name: name ?? this.name,
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }
}
