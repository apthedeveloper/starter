import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';
import 'package:starter_project/gen/app_localizations_en.dart';

class SendVerificationEmailUseCase {
  final AuthRepository repository;

  SendVerificationEmailUseCase(this.repository);

  Future<bool> call() async {
    final isLoggedIn = await repository.getFirebaseUser();
    if (isLoggedIn == null) {
      throw ApiException(AppLocalizationsEn().userIsNotLoggedIn);
    }

    return asyncUseCase(() async {
      final isSuccess = await repository.sendVerificationEmail();

      if (isSuccess==null ||  isSuccess == false) {
        throw ApiException(AppLocalizationsEn().failedToSendVerificationEmailPleaseTryAgainLater);
      }
      return isSuccess;
    });
  }
}
