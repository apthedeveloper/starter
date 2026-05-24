import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';

class RefreshCurrentUserUseCase {
  final AuthRepository repository;

  RefreshCurrentUserUseCase(this.repository);

  Future<User> call() async {
    final isLoggedIn = await repository.getFirebaseUser();
    if (isLoggedIn == null) {
      throw ApiException("User is not logged in");
    }

    return asyncUseCase(() async {
      final user = await repository.fetchUserProfile();

      if (user == null ) {
        throw ApiException("Failed to get user profile. Please try again later.");
      }
      return user;
    });
  }
}
