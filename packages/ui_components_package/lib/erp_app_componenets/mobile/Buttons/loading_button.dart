import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const LoadingButton({super.key, required this.text, required this.onPressed});

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;

  void _handlePress() async {
    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 2)); // شبیه‌سازی عملیات
      widget.onPressed();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // کل عرض والد
      height: 50,
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: 10, right: 10),
        child: MaterialButton(
          onPressed: _isLoading ? null : _handlePress,
          color: Colors.black,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
          ),
          child: _isLoading
              ? CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3,
                  strokeAlign: 1,
                  padding: EdgeInsetsGeometry.all(10),
                )
              : Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
