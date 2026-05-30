import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';
import 'package:starter_project/gen/app_localizations_en.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<bool> call({required String email}) async {
    if (email.trim().isEmpty) {
      throw ApiException(AppLocalizationsEn().emailIsRequired);
    }

    return asyncUseCase(() async {
      final isSuccess = await repository.forgetPassword(email: email);

      if (isSuccess == null || isSuccess == false) {
        throw ApiException(AppLocalizationsEn().failedToResetPasswordPleaseTryAgainLater);
      }
      return isSuccess;
    });
  }
}
