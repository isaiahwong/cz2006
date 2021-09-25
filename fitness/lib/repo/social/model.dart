import 'package:fitness/repo/repo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Friends {
  List<User> users;
  Friends(this.users);

  factory Friends.fromJson(Map<String, dynamic> json) =>
      _$FriendsFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsToJson(this);
}
