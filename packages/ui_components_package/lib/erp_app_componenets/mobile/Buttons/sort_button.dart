import 'package:flutter/material.dart';

class RotatingSortButton extends StatefulWidget {
  const RotatingSortButton({super.key});

  @override
  State<RotatingSortButton> createState() => _RotatingSortButtonState();
}

class _RotatingSortButtonState extends State<RotatingSortButton> {
  double rotationAngle = 0; // زاویه چرخش به رادیان (0 یا π)

  void _toggleRotation() {
    setState(() {
      rotationAngle = rotationAngle == 0 ? 3.1416 : 0; // 180 درجه = π رادیان
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleRotation,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(46, 46),
        maximumSize: const Size(46, 46),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: const Color(0xFFECECEC),
        surfaceTintColor: Colors.transparent,
      ),
      child: AnimatedRotation(
        turns: rotationAngle / (2 * 3.1416), // تبدیل رادیان به دور کامل
        duration: const Duration(milliseconds: 300),
        child: Image.asset(
          'assets/images/sort.png',
          package:'resources_package',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
