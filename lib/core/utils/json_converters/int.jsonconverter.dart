import 'package:freezed_annotation/freezed_annotation.dart';

class IntConverter
    implements JsonConverter<int, dynamic> {
  const IntConverter();

  @override
  int fromJson(dynamic json) {
    switch (json) {
      case null:
        throw FormatException(
          'Int value cannot be null',
        );

      case num():
        return json.toInt();

      case String():
        final parsed = int.tryParse(json.trim());

        if (parsed != null) return parsed;

        throw FormatException(
          'Cannot parse "$json" into int.',
        );

      default:
        throw FormatException(
          'Invalid int type: ${json.runtimeType}',
        );
    }
  }

  @override
  dynamic toJson(int object) => object;
}


class NullableIntConverter
    implements JsonConverter<int?, dynamic> {
  const NullableIntConverter();

  @override
  int? fromJson(dynamic json) {
    switch (json) {
      case null:
        return null;

      case num():
        return json.toInt();

      case String():
        final parsed = int.tryParse(json.trim());

        if (parsed != null) return parsed;

        throw FormatException(
          'Cannot parse "$json" into int.',
        );

      default:
        throw FormatException(
          'Invalid int type: ${json.runtimeType}',
        );
    }
  }

  @override
  dynamic toJson(int? object) => object;
}