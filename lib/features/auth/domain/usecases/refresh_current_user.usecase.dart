import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';
import 'package:starter_project/gen/app_localizations_en.dart';

class RefreshCurrentUserUseCase {
  final AuthRepository repository;

  RefreshCurrentUserUseCase(this.repository);

  Future<User> call() async {
    final isLoggedIn = await repository.getFirebaseUser();
    if (isLoggedIn == null) {
      throw ApiException(AppLocalizationsEn().userIsNotLoggedIn);
    }

    return asyncUseCase(() async {
      final user = await repository.fetchUserProfile();

      if (user == null ) {
        throw ApiException(AppLocalizationsEn().failedToGetUserProfilePleaseTryAgainLater);
      }
      return user;
    });
  }
}
