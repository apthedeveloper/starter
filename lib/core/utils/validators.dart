import 'package:flutter/widgets.dart';
import 'package:starter_project/core/constants/app_regx.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';

final class Validators {
  Validators._();

  /// Required field
  static String? required(BuildContext context, String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return context.localizations.fieldRequired(fieldName ?? context.localizations.thisField);
    }
    return null;
  }

  /// Email validation
  static String? email(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.localizations.emailRequired;
    }

    if (!AppRegex.email.hasMatch(value.trim())) {
      return context.localizations.enterValidEmail;
    }

    return null;
  }

  /// Password validation
  static String? password(BuildContext context, String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return context.localizations.passwordRequired;
    }

    if (value.length < minLength) {
      return context.localizations.passwordMinLengthError(minLength);
    }

    return null;
  }

  /// Strong password (optional advanced)
  static String? strongPassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.localizations.passwordRequired;
    }

    if (!AppRegex.strongPassword.hasMatch(value)) {
      return context.localizations.strongPasswordError;
    }

    return null;
  }

  /// Phone number (basic)
  static String? phone(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.localizations.phoneRequired;
    }

    final phoneRegex = RegExp(r'^[0-9]{10}$');

    if (!phoneRegex.hasMatch(value)) {
      return context.localizations.enterValidPhone;
    }

    return null;
  }

  /// Min length
  static String? minLength(BuildContext context, String? value, int length) {
    if (value == null || value.length < length) {
      return context.localizations.minLengthError(length);
    }
    return null;
  }

  /// Max length
  static String? maxLength(BuildContext context, String? value, int length) {
    if (value != null && value.length > length) {
      return context.localizations.maxLengthError(length);
    }
    return null;
  }

  /// Number validation
  static String? number(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.localizations.thisFieldRequired;
    }

    if (double.tryParse(value) == null) {
      return context.localizations.enterValidNumber;
    }

    return null;
  }

  /// Confirm password
  static String? confirmPassword(BuildContext context, String? value, String original) {
    if (value == null || value.isEmpty) {
      return context.localizations.pleaseConfirmPassword;
    }

    if (value != original) {
      return context.localizations.passwordsDoNotMatch;
    }

    return null;
  }

  /// Multiple validators
  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
}
