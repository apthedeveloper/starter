import 'package:go_router/go_router.dart';
import 'package:starter_project/app/routes/app_routes.dart';
import 'package:starter_project/features/auth/presentation/screens/login_screen.dart';

final class AppRouter {
  AppRouter._();
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => LoginScreen()),
    ],
    
  );
}
