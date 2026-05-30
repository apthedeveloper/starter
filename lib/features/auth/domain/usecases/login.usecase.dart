import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';
import 'package:starter_project/gen/app_localizations_en.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call({required String email, required String password}) async {
    if (email.trim().isEmpty) {
      throw ApiException(AppLocalizationsEn().emailIsRequired);
    }
    if (password.trim().isEmpty) {
      throw ApiException(AppLocalizationsEn().passwordIsRequired);
    }

    return asyncUseCase(() async {
      final isSuccess = await repository.login(
        email: email,
        password: password,
        isSignup: false,
      );

      if (isSuccess == null || isSuccess == false) {
        throw ApiException(AppLocalizationsEn().failedToLoginPleaseTryAgainLater);
      }


      return isSuccess;
    });
  }
}
