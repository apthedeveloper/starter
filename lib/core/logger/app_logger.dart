import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

final class AppLogger {
  AppLogger._();

  static void t(
    dynamic message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) return;

    developer.log(
      message,
      name: _formatTitle('TRACE', tag),
      level: 300,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void d(
    dynamic message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) return;

    developer.log(
      message,
      name: _formatTitle('DEBUG', tag),
      level: 500,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void i(
    dynamic message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _formatTitle('INFO', tag),
      level: 800,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void w(
    dynamic message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _formatTitle('WARNING', tag),
      level: 900,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void e(
    dynamic message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _formatTitle('ERROR', tag),
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void f(
    dynamic message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _formatTitle('FATAL', tag),
      level: 1200,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static String _formatTitle(String type, String? tag) {
    if (tag == null || tag.trim().isEmpty) {
      return type.toString();
    }

    return '$type | $tag';
  }
}
