import 'package:flutter/widgets.dart' show SizedBox;
extension SpaceExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}