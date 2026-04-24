final class Validators {
  Validators._();

  /// Required field
  static String? required(String? value, {String fieldName = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  /// Email validation
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }

    return null;
  }

  /// Password validation
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < minLength) {
      return "Password must be at least $minLength characters";
    }

    return null;
  }

  /// Strong password (optional advanced)
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$',
    );

    if (!regex.hasMatch(value)) {
      return "Password must include upper, lower, number & special char";
    }

    return null;
  }

  /// Phone number (basic)
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    final phoneRegex = RegExp(r'^[0-9]{10}$');

    if (!phoneRegex.hasMatch(value)) {
      return "Enter valid 10-digit phone number";
    }

    return null;
  }

  /// Min length
  static String? minLength(String? value, int length) {
    if (value == null || value.length < length) {
      return "Minimum $length characters required";
    }
    return null;
  }

  /// Max length
  static String? maxLength(String? value, int length) {
    if (value != null && value.length > length) {
      return "Maximum $length characters allowed";
    }
    return null;
  }

  /// Number validation
  static String? number(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }

    if (double.tryParse(value) == null) {
      return "Enter a valid number";
    }

    return null;
  }

  /// Confirm password
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return "Please confirm password";
    }

    if (value != original) {
      return "Passwords do not match";
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
