import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter
    implements JsonConverter<DateTime, dynamic> {
  const DateTimeConverter();

  @override
  DateTime fromJson(dynamic json) {
    switch (json) {
      case null:
        throw FormatException(
          'DateTime value cannot be null',
        );

      case String():
        final parsed = DateTime.tryParse(json);

        if (parsed != null) return parsed;

        throw FormatException(
          'Cannot parse "$json" into DateTime.',
        );

      case int():
        if (json.toString().length == 10) {
          return DateTime.fromMillisecondsSinceEpoch(
            json * 1000,
          );
        }

        return DateTime.fromMillisecondsSinceEpoch(json);

      default:
        throw FormatException(
          'Invalid DateTime type: ${json.runtimeType}',
        );
    }
  }

  @override
  dynamic toJson(DateTime object) =>
      object.toIso8601String();
}


class NullableDateTimeConverter
    implements JsonConverter<DateTime?, dynamic> {
  const NullableDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    switch (json) {
      case null:
        return null;

      case String():
        final parsed = DateTime.tryParse(json);

        if (parsed != null) return parsed;

        throw FormatException(
          'Cannot parse "$json" into DateTime.',
        );

      case int():
        if (json.toString().length == 10) {
          return DateTime.fromMillisecondsSinceEpoch(
            json * 1000,
          );
        }

        return DateTime.fromMillisecondsSinceEpoch(json);

      default:
        throw FormatException(
          'Invalid DateTime type: ${json.runtimeType}',
        );
    }
  }

  @override
  dynamic toJson(DateTime? object) =>
      object?.toIso8601String();
}