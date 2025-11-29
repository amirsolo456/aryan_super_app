import 'package:flutter/material.dart';

class CustomDynamicButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double size;
  final double borderRadius;
  final double elevation;
  final bool useDefaultAnimation;

  const CustomDynamicButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFECECEC),
    this.size = 36,
    this.borderRadius = 6,
    this.elevation = 0,
    this.useDefaultAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    if (useDefaultAnimation) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size, size),
          maximumSize: Size(size, size),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation,
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        child: icon,
      );
    } else {
      return IconButton(
        onPressed: onPressed,
        icon: icon,
        highlightColor: Colors.black.withAlpha(0),
      );
    }
  }
}
