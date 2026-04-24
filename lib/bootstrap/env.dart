import 'flavor.dart';

final class Env {
  Env._();

  static String get appName {
    switch (AppFlavor.current) {
      case Flavor.dev:
        return 'Starter App (Dev)';
      case Flavor.staging:
        return 'Starter App (Staging)';
      case Flavor.prod:
        return 'Starter App';
    }
  }

  static String get baseUrl {
    switch (AppFlavor.current) {
      case Flavor.dev:
        return 'https://dev-api.example.com';
      case Flavor.staging:
        return 'https://staging-api.example.com';
      case Flavor.prod:
        return 'https://api.example.com';
    }
  }

  static bool get enableLogging {
    switch (AppFlavor.current) {
      case Flavor.dev:
      case Flavor.staging:
        return true;
      case Flavor.prod:
        return false;
    }
  }

  static bool get isProduction => AppFlavor.isProd;
}