import 'package:flutter/material.dart';

final class FeedbackService {
  FeedbackService._();

  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static ScaffoldMessengerState? get _messenger => messengerKey.currentState;

  static void showSnackbar(SnackBar snackBar) {
    if (_messenger == null) return;

    _messenger!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void clearSnackbars() {
    _messenger?.clearSnackBars();
  }
}
