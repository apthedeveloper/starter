import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider;
import 'package:flutter_riverpod/legacy.dart' show StateNotifierProvider;
import 'package:starter_project/features/auth/data/repositories/firebase_auth.repository_impl.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';
import 'package:starter_project/features/auth/presentation/controller/auth.controller.dart';
import 'package:starter_project/features/auth/presentation/state/auth.state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthImpl();
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref.watch(authRepositoryProvider)),
);
