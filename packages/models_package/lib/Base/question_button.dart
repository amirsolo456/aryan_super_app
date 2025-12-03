import 'package:flutter/material.dart';

class QuestionButton {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  QuestionButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  });
}
