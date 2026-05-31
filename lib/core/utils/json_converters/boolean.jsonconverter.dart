import 'package:freezed_annotation/freezed_annotation.dart';

class BoolConverter implements JsonConverter<bool, dynamic> {
  const BoolConverter();

  @override
  bool fromJson(dynamic json) {
    switch (json) {
      case null:
        throw FormatException('Bool value cannot be null');

      case bool():
        return json;

      case num():
        if (json == 1) return true;
        if (json == 0) return false;

        throw FormatException('Invalid numeric bool value: $json');

      case String():
        final value = json.trim().toLowerCase();

        if (value == 'true') return true;
        if (value == 'false') return false;
        if (value == '1') return true;
        if (value == '0') return false;

        throw FormatException('Cannot parse "$json" into bool.');

      default:
        throw FormatException('Invalid bool type: ${json.runtimeType}');
    }
  }

  @override
  dynamic toJson(bool object) => object;
}

class NullableBoolConverter implements JsonConverter<bool?, dynamic> {
  const NullableBoolConverter();

  @override
  bool? fromJson(dynamic json) {
    switch (json) {
      case null:
        return null;

      case bool():
        return json;

      case num():
        if (json == 1) return true;
        if (json == 0) return false;

        throw FormatException('Invalid numeric bool value: $json');

      case String():
        final value = json.trim().toLowerCase();

        if (value == 'true') return true;
        if (value == 'false') return false;
        if (value == '1') return true;
        if (value == '0') return false;

        throw FormatException('Cannot parse "$json" into bool.');

      default:
        throw FormatException('Invalid bool type: ${json.runtimeType}');
    }
  }

  @override
  dynamic toJson(bool? object) => object;
}
