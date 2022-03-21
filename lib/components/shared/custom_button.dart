import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

abstract class _CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const _CustomButton({
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(primary: color),
      child: Text(
        text,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}

class ErrorButton extends _CustomButton {
  const ErrorButton({
    required text,
    required onPressed,
    required,
  }) : super(onPressed: onPressed, text: text, color: red);
}

class SuccessButton extends _CustomButton {
  const SuccessButton({
    required text,
    required onPressed,
    required,
  }) : super(onPressed: onPressed, text: text, color: green);
}
