import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_project/core/logger/app_logger.dart';
import 'package:starter_project/core/network/json_keys.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
part 'user.model.freezed.dart';
part 'user.model.g.dart';

@freezed
sealed class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String email,
    required bool isEmailVerified,
    String? name,
    String? bio,
    String? dateOfBirth,
    String? gender,
    String? profileImagePath,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSnapshot(
    String id,
    bool isEmailVerified,
    DocumentSnapshot snapshot,
  ) {
    AppLogger.i(
      "${{id: id, isEmailVerified: isEmailVerified, ...snapshot.data() as Map<String, dynamic>}}",
      tag: "UserModel.fromSnapshot",
    );
    return UserModel.fromJson({
      ...snapshot.data() as Map<String, dynamic>,
      JsonKeys.id: id,
      JsonKeys.isEmailVerified: isEmailVerified,
    });
  }
  User toEntity() {
    return User(
      id: id,
      email: email,
      isEmailVerified: isEmailVerified,
      name: name,
      bio: bio,
      dateOfBirth: dateOfBirth,
      gender: gender,
      profileImagePath: profileImagePath,
    );
  }
}
