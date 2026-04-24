import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:starter_project/app/core/extensions/context.extenstion.dart';

class AppTextSpan {
  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;

  AppTextSpan({required this.text, this.style, this.onTap});
}

class AppRichText extends StatelessWidget {
  final List<AppTextSpan> spans;
  final TextAlign textAlign;

  const AppRichText({
    super.key,
    required this.spans,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = context.textTheme.bodyMedium;

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: defaultStyle,
        children: spans.map((span) {
          return TextSpan(
            text: "${span.text} ",
            style: _resolveStyle( defaultStyle, span.style, context.colors.primary, span.onTap != null),
            recognizer: span.onTap != null
                ? (TapGestureRecognizer()..onTap = span.onTap)
                : null,
          );
        }).toList(),
      ),
    );
  }

  TextStyle _resolveStyle(
    TextStyle? base,
    TextStyle? override,
    Color primaryColor,
    bool isClickable,
  ) {
    final b = base ?? const TextStyle();

    return b.copyWith(
      color: override?.color ?? (isClickable ? primaryColor: b.color),
      fontWeight:
          override?.fontWeight ??
          (isClickable ? FontWeight.w500 : b.fontWeight),
      decoration:
          override?.decoration ??
          (isClickable ? TextDecoration.underline : b.decoration),
      decorationColor:
          override?.decorationColor ??
          (isClickable ? primaryColor: b.color),
      fontSize: override?.fontSize ?? b.fontSize,
      fontStyle: override?.fontStyle ?? b.fontStyle,
      letterSpacing: override?.letterSpacing ?? b.letterSpacing,
      height: override?.height ?? b.height,
    );
  }
}
