import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String email;
  @JsonKey(defaultValue: 0)
  final int height;
  @JsonKey(defaultValue: "")
  final String profilePicture;

  // TODO: Add workouts, weights, workoutevents
  // friends is in a subcollection by itself

  User({
    required this.id,
    required this.email,
    required this.name,
    this.height = 0,
    this.profilePicture = "",
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    int? height,
    String? profilePicture,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      height: height ?? this.height,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
