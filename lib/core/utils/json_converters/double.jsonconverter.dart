import 'package:freezed_annotation/freezed_annotation.dart';

class DoubleConverter implements JsonConverter<double, dynamic> {
  const DoubleConverter();

  @override
  double fromJson(dynamic json) {
    switch (json) {
      case null:
        throw FormatException('Double value cannot be null');

      case num():
        return json.toDouble();

      case String():
        final parsed = double.tryParse(json.trim());

        if (parsed != null) {
          return parsed;
        }

        throw FormatException('Cannot parse "$json" into double.');

      default:
        throw FormatException('Invalid double type: ${json.runtimeType}');
    }
  }

  @override
  dynamic toJson(double object) => object;
}

class NullableDoubleConverter implements JsonConverter<double?, dynamic> {
  const NullableDoubleConverter();

  @override
  double? fromJson(dynamic json) {
    switch (json) {
      case null:
        return null;

      case num():
        return json.toDouble();

      case String():
        final parsed = double.tryParse(json.trim());

        if (parsed != null) {
          return parsed;
        }

        throw FormatException('Cannot parse "$json" into double.');

      default:
        throw FormatException('Invalid double type: ${json.runtimeType}');
    }
  }

  @override
  dynamic toJson(double? object) => object;
}
