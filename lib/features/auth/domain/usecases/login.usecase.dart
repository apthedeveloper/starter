import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call({required String email, required String password}) async {
    if (email.trim().isEmpty) {
      throw ApiException("Email is required");
    }
    if (password.trim().isEmpty) {
      throw ApiException("Password is required");
    }

    return asyncUseCase(() async {
      final isSuccess = await repository.login(
        email: email,
        password: password,
        isSignup: false,
      );

      if (isSuccess == null || isSuccess == false) {
        throw ApiException("Failed to login. Please try again later.");
      }


      final user = await repository.fetchUserProfile();

      if (user == null ) {
        throw ApiException("Failed to get user profile. Please try again later.");
      }

      return user;
    });
  }
}
