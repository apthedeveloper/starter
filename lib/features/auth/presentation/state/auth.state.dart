import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
import 'package:starter_project/shared/states/api.state.dart';

class AuthState {
  final ApiState<User?> userState;
  final bool secondaryLoader;
  final bool isInitializing;

  AuthState({
    required this.userState,
    this.secondaryLoader = false,
    this.isInitializing = true,
  });

  AuthState copyWith({
    ApiState<User?>? userState,
    bool? otherLoader,
    bool? isInitializing,
  }) {
    return AuthState(
      userState: userState ?? this.userState,
      secondaryLoader: otherLoader ?? this.secondaryLoader,
      isInitializing: isInitializing ?? this.isInitializing,
    );
  }
}
