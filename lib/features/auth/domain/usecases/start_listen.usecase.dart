import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/utils/callback/stream_callback.usecase.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';

class StartListenUserStateChangesUseCase {
  final AuthRepository repository;

  StartListenUserStateChangesUseCase(this.repository);

  Stream<User?> call() {
    return streamUseCase(() {
      return repository.startListenUserStateChanges().handleError((
        error,
        stackTrace,
      ) {
        if (error is ApiException) {
          throw error;
        }
        throw ApiException(
          "Failed to listen auth state changes",
          raw: error,
          stackTrace: stackTrace,
        );
      });
    });
  }
}
