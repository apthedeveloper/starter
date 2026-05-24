import 'package:starter_project/app/app.dart';
import 'package:starter_project/bootstrap/bootstrap.dart';
import 'package:starter_project/bootstrap/flavor.dart';

void main() async {
  
  await bootstrap(flavor: Flavor.prod, builder: () => App());
}
