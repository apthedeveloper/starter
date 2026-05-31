import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:starter_project/core/config/config.dart';

class ProdConfig implements AppConfig {
  @override
  String get appName => 'Starter App';

  @override
  String get baseUrl => dotenv.get('PROD_BASE_URL');

  @override
  String get apiKey => dotenv.get('PROD_X-API-KEY');

  @override
  bool get enableLogging => false;

  @override
  int get projectId => dotenv.getInt('PROD_PROJECT_ID');
}
