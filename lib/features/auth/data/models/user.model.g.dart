// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  isEmailVerified: json['is_email_verified'] as bool,
  name: json['name'] as String?,
  bio: json['bio'] as String?,
  dateOfBirth: json['date_of_birth'] as String?,
  gender: json['gender'] as String?,
  profileImagePath: json['profile_image_path'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'is_email_verified': instance.isEmailVerified,
      'name': instance.name,
      'bio': instance.bio,
      'date_of_birth': instance.dateOfBirth,
      'gender': instance.gender,
      'profile_image_path': instance.profileImagePath,
    };
