import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_project/app/theme/colors/app_colors.dart';
import 'package:starter_project/bootstrap/flavor.dart';

Future<void> bootstrap({required Flavor flavor, required Widget Function() builder})async {
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,

      systemNavigationBarColor:AppColors.white, 
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  AppFlavor.setFlavor(flavor);
  runApp(builder());
}
