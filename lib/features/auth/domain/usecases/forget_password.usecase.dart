import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<bool> call({required String email}) async {
    if (email.trim().isEmpty) {
      throw ApiException("Email is required");
    }

    return asyncUseCase(() async {
      final isSuccess = await repository.forgetPassword(email: email);

      if (isSuccess == null || isSuccess == false) {
        throw ApiException("Failed to reset password. Please try again later.");
      }
      return isSuccess;
    });
  }
}
