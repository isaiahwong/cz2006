// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    dateOfBirth: json['dateOfBirth'] as int? ?? 0,
    height: json['height'] as int? ?? 0,
    profilePicture: json['profilePicture'] as String? ?? '',
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth,
      'height': instance.height,
      'profilePicture': instance.profilePicture,
    };
