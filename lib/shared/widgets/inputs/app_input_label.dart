import 'package:flutter/material.dart';

class AppFieldLabel extends StatelessWidget {
  final String text;
  final bool isRequired;

  const AppFieldLabel({super.key, required this.text, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.labelLarge,
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
