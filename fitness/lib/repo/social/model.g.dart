// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friends _$FriendsFromJson(Map<String, dynamic> json) {
  return Friends(
    (json['users'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FriendsToJson(Friends instance) => <String, dynamic>{
      'users': instance.users,
    };

FriendRequest _$FriendRequestFromJson(Map<String, dynamic> json) {
  return FriendRequest(
    json['createdAt'] as int,
    UserSnippet.fromJson(json['initiator'] as Map<String, dynamic>),
    UserSnippet.fromJson(json['responder'] as Map<String, dynamic>),
    _$enumDecode(_$SocialStatusEnumMap, json['socialStatus']),
  );
}

Map<String, dynamic> _$FriendRequestToJson(FriendRequest instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'initiator': instance.initiator,
      'responder': instance.responder,
      'socialStatus': _$SocialStatusEnumMap[instance.socialStatus],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$SocialStatusEnumMap = {
  SocialStatus.FRIEND: 1,
  SocialStatus.UNFRIEND: 2,
  SocialStatus.PENDING: 3,
  SocialStatus.DECLINE: 4,
};

UserSnippet _$UserSnippetFromJson(Map<String, dynamic> json) {
  return UserSnippet(
    json['id'] as String,
    json['name'] as String,
    json['profilePicture'] as String,
  );
}

Map<String, dynamic> _$UserSnippetToJson(UserSnippet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profilePicture': instance.profilePicture,
    };
