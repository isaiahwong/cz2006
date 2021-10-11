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

Friend _$FriendFromJson(Map<String, dynamic> json) {
  return Friend(
    json['id'] as String,
    json['createdAt'] as int,
    UserSnippet.fromJson(json['initiator'] as Map<String, dynamic>),
    UserSnippet.fromJson(json['responder'] as Map<String, dynamic>),
    _$enumDecode(_$SocialStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'id': instance.id,
      'initiator': instance.initiator,
      'responder': instance.responder,
      'status': _$SocialStatusEnumMap[instance.status],
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
  SocialStatus.FRIEND: 'FRIEND',
  SocialStatus.UNFRIEND: 'UNFRIEND',
  SocialStatus.PENDING: 'PENDING',
  SocialStatus.DECLINE: 'DECLINE',
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
