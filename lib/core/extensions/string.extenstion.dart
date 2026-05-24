enum MaskType { auto, email, phone, card, custom }

extension StringMaskingExtension on String {
  // =========================================================
  // MAIN MASKING API
  // =========================================================

  String masked({
    MaskType type = MaskType.auto,
    int showFirst = 2,
    int showLast = 2,
    String maskChar = '*',
  }) {
    if (trim().isEmpty) return this;

    final value = trim();

    switch (type) {
      case MaskType.email:
        return _maskEmail(
          value,
          visibleChars: showFirst,
          maskChar: maskChar,
        );

      case MaskType.phone:
        return _maskGeneric(
          value,
          showFirst: showFirst,
          showLast: showLast,
          maskChar: maskChar,
        );

      case MaskType.card:
        return _maskCard(
          value,
          showLast: showLast,
          maskChar: maskChar,
        );

      case MaskType.custom:
        return _maskGeneric(
          value,
          showFirst: showFirst,
          showLast: showLast,
          maskChar: maskChar,
        );

      case MaskType.auto:
        return _autoMask(
          value,
          showFirst: showFirst,
          showLast: showLast,
          maskChar: maskChar,
        );
    }
  }

  // =========================================================
  // VALIDATION
  // =========================================================

  bool get isEmail {
    return RegExp(
      r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(trim());
  }

  bool get isPhone {
    final digits = digitsOnly;
    return digits.length >= 8 && digits.length <= 15;
  }

  bool get isCard {
    final digits = digitsOnly;
    return digits.length >= 13 && digits.length <= 19;
  }

  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => trim().isNotEmpty;

  // =========================================================
  // FORMATTERS
  // =========================================================

  String get digitsOnly {
    return replaceAll(RegExp(r'\D'), '');
  }

  String get reversed {
    return split('').reversed.join();
  }

  String capitalize() {
    if (isBlank) return this;

    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String titleCase() {
    if (isBlank) return this;

    return split(' ')
        .map((e) => e.capitalize())
        .join(' ');
  }

  String removeExtraSpaces() {
    return trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  String limit(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;

    return substring(0, maxLength) + suffix;
  }

  String initials({int limit = 2}) {
    if (isBlank) return '';

    final words = removeExtraSpaces().split(' ');

    return words
        .take(limit)
        .map((e) => e[0].toUpperCase())
        .join();
  }

  // =========================================================
  // SAFE PARSERS
  // =========================================================

  int? get toIntOrNull => int.tryParse(trim());

  double? get toDoubleOrNull => double.tryParse(trim());

  bool? get toBoolOrNull {
    switch (trim().toLowerCase()) {
      case 'true':
      case '1':
      case 'yes':
        return true;

      case 'false':
      case '0':
      case 'no':
        return false;

      default:
        return null;
    }
  }

  // =========================================================
  // COMMON HELPERS
  // =========================================================

  String repeat(int times) {
    return List.filled(times, this).join();
  }

  bool equalsIgnoreCase(String other) {
    return toLowerCase() == other.toLowerCase();
  }

  bool containsIgnoreCase(String other) {
    return toLowerCase().contains(other.toLowerCase());
  }

  String safeSubstring(
    int start, [
    int? end,
  ]) {
    if (start >= length) return '';

    end ??= length;

    if (end > length) {
      end = length;
    }

    return substring(start, end);
  }

  // =========================================================
  // AUTO DETECTION
  // =========================================================

  String _autoMask(
    String value, {
    required int showFirst,
    required int showLast,
    required String maskChar,
  }) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    if (value.contains('@')) {
      return _maskEmail(
        value,
        visibleChars: showFirst,
        maskChar: maskChar,
      );
    }

    if (digitsOnly.length >= 13 && digitsOnly.length <= 19) {
      return _maskCard(
        value,
        showLast: 4,
        maskChar: maskChar,
      );
    }

    if (digitsOnly.length >= 8 && digitsOnly.length <= 15) {
      return _maskGeneric(
        value,
        showFirst: showFirst,
        showLast: showLast,
        maskChar: maskChar,
      );
    }

    return _maskGeneric(
      value,
      showFirst: showFirst,
      showLast: showLast,
      maskChar: maskChar,
    );
  }

  // =========================================================
  // EMAIL
  // =========================================================

  String _maskEmail(
    String value, {
    required int visibleChars,
    required String maskChar,
  }) {
    final parts = value.split('@');

    if (parts.length != 2) {
      return _maskGeneric(
        value,
        showFirst: 1,
        showLast: 1,
        maskChar: maskChar,
      );
    }

    final local = parts.first;
    final domain = parts.last;

    if (local.length <= visibleChars) {
      return '${local[0]}${maskChar * (local.length - 1)}@$domain';
    }

    final visible = local.substring(0, visibleChars);
    final masked = maskChar * (local.length - visibleChars);

    return '$visible$masked@$domain';
  }

  // =========================================================
  // CARD
  // =========================================================

  String _maskCard(
    String value, {
    required int showLast,
    required String maskChar,
  }) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length <= showLast) {
      return value;
    }

    final masked =
        (maskChar * (digitsOnly.length - showLast)) +
        digitsOnly.substring(digitsOnly.length - showLast);

    final buffer = StringBuffer();

    for (int i = 0; i < masked.length; i++) {
      buffer.write(masked[i]);

      if ((i + 1) % 4 == 0 && i != masked.length - 1) {
        buffer.write(' ');
      }
    }

    return buffer.toString();
  }

  // =========================================================
  // GENERIC
  // =========================================================

  String _maskGeneric(
    String value, {
    required int showFirst,
    required int showLast,
    required String maskChar,
  }) {
    if (value.length <= showFirst + showLast) {
      return maskChar * value.length;
    }

    final start = value.substring(0, showFirst);
    final end = value.substring(value.length - showLast);

    final maskedLength = value.length - showFirst - showLast;

    return start + (maskChar * maskedLength) + end;
  }
}