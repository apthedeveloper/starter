import 'package:starter_project/bootstrap/flavor.dart';
import 'package:starter_project/core/config/dev_config.dart';
import 'package:starter_project/core/config/prod_config.dart';
import 'package:starter_project/core/config/staging_config.dart';

abstract class AppConfig {
  String get appName;
  String get baseUrl;
  String get apiKey;
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