import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';
import 'package:starter_project/gen/app_localizations_en.dart';

class CompleteProfileUseCase {
  final AuthRepository repository;

  CompleteProfileUseCase(this.repository);

  Future<bool> call({
    required Map<String, dynamic> data,
    required String profileLocalPath,
  }) async {
    final isLoggedIn = await repository.getFirebaseUser();
    if (isLoggedIn == null) {
      throw ApiException(AppLocalizationsEn().userIsNotLoggedIn);
    }

    return asyncUseCase(() async {
      // await repository.deleteProfile().onError((error, stackTrace) => null);

      // data[JsonKeys.profileImagePath] = await repository.uploadProfile(
      //   profileLocalPath,
      // );

      final isSuccess = await repository.completeProfile(data);

      if (isSuccess == null || isSuccess == false) {
        throw ApiException(
          AppLocalizationsEn().failedToUpdateProfilePleaseTryAgainLater,
        );
      }
      return isSuccess;
    });
  }
}
