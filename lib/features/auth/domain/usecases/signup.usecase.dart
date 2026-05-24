import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/network/json_keys.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<User> call({required String email, required String password}) async {
    if (email.trim().isEmpty) {
      throw ApiException("Email is required");
    }
    if (password.trim().isEmpty) {
      throw Exception("Password is required");
    }
    return asyncUseCase(() async {
      final isSuccess = await repository.login(
        email: email,
        password: password,
        isSignup: true,
      );

      if (isSuccess == null || isSuccess == false) {
        throw ApiException("Failed to signup. Please try again later.");
      }

      final user = await repository.completeProfile({JsonKeys.email: email});

      if (user == null) {
        throw ApiException(
          "Failed to get user profile. Please try again later.",
        );
      }
      return user;
    });
  }
}
