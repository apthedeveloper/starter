import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';

class DeleteProfileUseCase {
  final AuthRepository repository;

  DeleteProfileUseCase(this.repository);

  Future<bool> call() async {
    final isLoggedIn = await repository.getFirebaseUser();
    if (isLoggedIn == null) {
      throw ApiException("User is not logged in");
    }

    return asyncUseCase(() async {
      final isSuccess = await repository.deleteProfile();

      if (isSuccess == null || isSuccess == false) {
        throw ApiException("Failed to delete profile. Please try again later.");
      }
      return isSuccess;
    });
  }
}
