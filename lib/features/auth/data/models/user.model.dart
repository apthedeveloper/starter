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
    @JsonKey(name: JsonKeys.id) required String id,
    @JsonKey(name: JsonKeys.email) required String email,
    @JsonKey(name: JsonKeys.isEmailVerified) required bool isEmailVerified,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSnapshot(
    String id,
    bool isEmailVerified,
    DocumentSnapshot snapshot,
  ) {
    AppLogger.i(
      "UserModel.fromSnapshot: ${id}, ${isEmailVerified}, ${snapshot.data() as Map<String, dynamic>}",
    );
    return UserModel.fromJson({
      ...snapshot.data() as Map<String, dynamic>,
      JsonKeys.id: id,
      JsonKeys.isEmailVerified: isEmailVerified,
    });
  }
  User toEntity() {
    return User(id: id, email: email, isEmailVerified: isEmailVerified);
  }
}


// class UserModel {
//   final String id;
//   final String email;

//   UserModel({
//     required this.id,
//     required this.email,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       email: json['email'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'email': email,
//       };

//   User toEntity() {
//     return User(id: id, email: email);
//   }

//   factory UserModel.fromEntity(User user) {
//     return UserModel(
//       id: user.id,
//       email: user.email,
//     );
//   }
// }