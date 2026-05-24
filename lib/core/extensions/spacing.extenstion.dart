import 'package:flutter/widgets.dart' show SizedBox, EdgeInsets;

extension SpaceExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());

  EdgeInsets get vp => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get hp => EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get ap => EdgeInsets.all(toDouble());
}
