import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/async_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';

class CompleteProfileUseCase {
  final AuthRepository repository;

  CompleteProfileUseCase(this.repository);

  Future<User> call({required Map<String, dynamic> data}) async {
    final isLoggedIn = await repository.getFirebaseUser();
    if (isLoggedIn == null) {
      throw ApiException("User is not logged in");
    }

    return asyncUseCase(() async {
      final user = await repository.completeProfile(data);

      if (user == null ) {
        throw ApiException("Failed to update profile. Please try again later.");
      }
      return user;
    });
  }
}
