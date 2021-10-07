import 'package:fitness/repo/repo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

enum SocialStatus {
  @JsonValue(1)
  FRIEND,
  @JsonValue(2)
  UNFRIEND,
  @JsonValue(3)
  PENDING,
  @JsonValue(4)
  DECLINE,
}

@JsonSerializable()
class Friends {
  List<User> users;
  Friends(this.users);

  factory Friends.fromJson(Map<String, dynamic> json) =>
      _$FriendsFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsToJson(this);
}

@JsonSerializable()
class FriendRequest {
  int createdAt;
  UserSnippet initiator;
  UserSnippet responder;
  SocialStatus socialStatus;

  FriendRequest(
    this.createdAt,
    this.initiator,
    this.responder,
    this.socialStatus,
  );

  FriendRequest copyWith({
    int? createdAt,
    UserSnippet? initiator,
    UserSnippet? responder,
    SocialStatus? socialStatus,
  }) {
    return FriendRequest(
      createdAt ?? this.createdAt,
      initiator ?? this.initiator,
      responder ?? this.responder,
      socialStatus ?? this.socialStatus,
    );
  }

  factory FriendRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FriendRequestToJson(this);
}

@JsonSerializable()
class UserSnippet {
  String id;
  String name;
  String profilePicture;

  UserSnippet(this.id, this.name, this.profilePicture);

  UserSnippet copyWith({String? id, String? name, String? profilePicture}) {
    return UserSnippet(
      id ?? this.id,
      name ?? this.name,
      profilePicture ?? this.profilePicture,
    );
  }

  /// Convert User to userSnippet
  static UserSnippet fromUser(User user) {
    return UserSnippet(
      user.id,
      user.name,
      user.profilePicture,
    );
  }

  factory UserSnippet.fromJson(Map<String, dynamic> json) =>
      _$UserSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$UserSnippetToJson(this);
}
