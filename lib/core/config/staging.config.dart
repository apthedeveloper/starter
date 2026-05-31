import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:starter_project/core/config/config.dart';

class StagingConfig implements AppConfig {
  @override
  String get appName => 'Starter App (Staging)';

  @override
  String get baseUrl => dotenv.get('STAGING_BASE_URL');

  @override
  String get apiKey => dotenv.get('STAGING_X-API-KEY');

  @override
  bool get enableLogging => true;

  @override
  int get projectId => dotenv.getInt('STAGING_PROJECT_ID');
}
