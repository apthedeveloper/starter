import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  //weight
  TextStyle bold() => copyWith(fontWeight: FontWeight.w700);
  TextStyle semiBold() => copyWith(fontWeight: FontWeight.w600);
  TextStyle medium() => copyWith(fontWeight: FontWeight.w500);

  //size
  TextStyle increaseSize(int value) =>
      copyWith(fontSize: (fontSize ?? 12) + value);
  TextStyle decreaseSize(int value) =>
      copyWith(fontSize: (fontSize ?? 12) - value);

  //letter spacing
  TextStyle increaseLetterSpacing(int value) =>
      copyWith(letterSpacing: (letterSpacing ?? 12) + value);
  TextStyle decreaseLetterSpacing(int value) =>
      copyWith(letterSpacing: (letterSpacing ?? 12) - value);

  TextStyle colour(Color c) => copyWith(color: c);
  TextStyle size(double s) => copyWith(fontSize: s);
}
