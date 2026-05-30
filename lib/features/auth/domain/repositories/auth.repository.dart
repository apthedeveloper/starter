import 'package:firebase_auth/firebase_auth.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart'
    as authuser;

abstract class AuthRepository {
  Future<User?> getFirebaseUser();
  Future<bool?> login({
    required String email,
    required String password,
    required bool isSignup,
  });
  Future<bool?> sendVerificationEmail();
  Future<bool?> isEmailVerified();
  Future<authuser.User?> fetchUserProfile();
  Future<bool?> completeProfile(final Map<String, dynamic> data);
  Future<bool?> forgetPassword({required String email});
  Future<bool> logout();
  Future<bool?> deleteProfile();
  Future<String?> uploadProfile(String path);

  Stream<authuser.User?> startListenUserStateChanges();
}
