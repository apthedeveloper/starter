import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config.dart';

final class DevConfig implements AppConfig {
  @override
  String get appName => 'Starter App (Dev)';

  @override
  String get baseUrl => dotenv.get('DEV_BASE_URL');

  @override
  String get apiKey => dotenv.get('DEV_X-API-KEY');

  @override
  bool get enableLogging => true;

  @override
  int get projectId => dotenv.getInt('DEV_PROJECT_ID');
}
