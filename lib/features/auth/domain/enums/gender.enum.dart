import 'package:flutter/material.dart';
import 'package:starter_project/gen/app_localizations.dart';
// Import your generated localization package here
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Gender {
  male('male'),
  female('female'),
  other('other'),
  unknown('unknown');

  // Keep the API value immutable
  final String apiValue;

  const Gender(this.apiValue);

  /// Dynamically fetches the localized name using BuildContext
  String localizedName(BuildContext context) {
    // Replace 'AppLocalizations' with your specific localization class name
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return apiValue;

    return switch (this) {
      Gender.male => localizations.genderMale,
      Gender.female => localizations.genderFemale,
      Gender.other => localizations.genderOther,
      Gender.unknown => localizations.genderUnknown,
    };
  }

  /// Converts an API string to the correct Gender enum
  static Gender fromString(String? value) {
    return Gender.values.firstWhere(
      (e) => e.apiValue == value?.toLowerCase(),
      orElse: () => Gender.unknown,
    );
  }
}
