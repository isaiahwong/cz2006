import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/repo/repo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

enum SocialStatus {
  @JsonValue("FRIEND")
  FRIEND,
  @JsonValue("UNFRIEND")
  UNFRIEND,
  @JsonValue("PENDING")
  PENDING,
  @JsonValue("DECLINE")
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

/// Representing in the user's subcollection friend
@JsonSerializable()
class Friend {
  int createdAt;
  String id;
  UserSnippet initiator;
  UserSnippet responder;
  SocialStatus status;

  UserSnippet get friend {
    return UserController.get().user.value!.id == initiator.id
        ? responder
        : initiator;
  }

  Friend(
    this.id,
    this.createdAt,
    this.initiator,
    this.responder,
    this.status,
  );

  Friend copyWith({
    int? createdAt,
    String? id,
    UserSnippet? initiator,
    UserSnippet? responder,
    SocialStatus? status,
  }) {
    return Friend(
      id ?? this.id,
      createdAt ?? this.createdAt,
      initiator ?? this.initiator,
      responder ?? this.responder,
      status ?? this.status,
    );
  }

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
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
