import 'package:flutter/material.dart';
import 'package:starter_project/core/extensions/textstyle_extenstion.dart';

class AppFieldLabel extends StatelessWidget {
  final String text;
  final bool isRequired;

  const AppFieldLabel({super.key, required this.text, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.labelLarge?.decreaseSize(1),
        children: [
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
