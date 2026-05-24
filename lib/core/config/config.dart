import 'package:starter_project/bootstrap/flavor.dart';
import 'package:starter_project/core/config/dev.config.dart';
import 'package:starter_project/core/config/prod.config.dart';
import 'package:starter_project/core/config/staging.config.dart';

abstract class AppConfig {
  String get appName;
  String get baseUrl;
  String get apiKey;
  int get projectId;
  bool get enableLogging;
}
final class AppEnvironment {
  AppEnvironment._();

  static late final AppConfig config;

  static void init(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        config = DevConfig();
        break;
      case Flavor.staging:
        config = StagingConfig();
        break;
      case Flavor.prod:
        config = ProdConfig();
        break;
    }
  }
}