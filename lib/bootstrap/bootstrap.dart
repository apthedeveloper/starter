import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_project/app/theme/colors/app_colors.dart';
import 'package:starter_project/bootstrap/flavor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:starter_project/core/config/config.dart';
import 'package:starter_project/core/config/firebase/firebase_options.dart';

Future<void> bootstrap({
  required Flavor flavor,
  required Widget Function() builder,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,

      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  AppFlavor.setFlavor(flavor);
  AppEnvironment.init(flavor);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: builder()));
}
