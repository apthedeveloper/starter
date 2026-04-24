import 'package:flutter/widgets.dart';
class AppLayout {
  AppLayout._();

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenWidth(BuildContext context) {
    return screenSize(context).width;
  }

  static double screenHeight(BuildContext context) {
    return screenSize(context).height;
  }


  /// Default horizontal padding
  static double horizontalPadding(BuildContext context) {
    return screenWidth(context) * 0.05;
  }

  /// Optional vertical padding
  static double verticalPadding(BuildContext context) {
    return screenHeight(context) * 0.02;
  }

  /// Combined screen padding
  static EdgeInsets screenPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding(context),
      vertical: verticalPadding(context),
    );
  }

  /// Only horizontal padding 
  static EdgeInsets horizontalEdgeInsets(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding(context),
    );
  }


  static bool isMobile(BuildContext context) {
    return screenWidth(context) < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= 1024;
  }


  static double maxContentWidth(BuildContext context) {
    final width = screenWidth(context);

    if (width > 1200) return 1000;
    if (width > 800) return 700;
    return width;
  }

  static EdgeInsets safeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }


  /// centered content on large screens
  static Widget centeredContent({
    required BuildContext context,
    required Widget child,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxContentWidth(context),
        ),
        child: child,
      ),
    );
  }
}