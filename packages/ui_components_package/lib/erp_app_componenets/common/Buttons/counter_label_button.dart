import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(body: Center(child: ExamplePage())),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  Future<void> _resendCode() async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('کد دوباره ارسال شد');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // اگر می‌خواهید زمان پیش‌فرض 28:01 باشه:
          ResendCodeTimer(
            initialDuration: const Duration(minutes: 28, seconds: 1),
            onResend: _resendCode,
          ),

          const SizedBox(height: 20),
          // یا نمونه کوتاه‌تر (مثلاً 30 ثانیه)
          ResendCodeTimer(
            initialDuration: const Duration(seconds: 30),
            onResend: () {
              debugPrint('resend from second button');
            },
          ),
        ],
      ),
    );
  }
}

class ResendCodeTimer extends StatefulWidget {
  final Duration initialDuration;
  final VoidCallback onResend;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  const ResendCodeTimer({
    super.key,
    required this.initialDuration,
    required this.onResend,
    this.textStyle,
    this.buttonStyle,
  });

  @override
  State<ResendCodeTimer> createState() => _ResendCodeTimerState();
}

class _ResendCodeTimerState extends State<ResendCodeTimer> {
  Timer? _ticker;
  late DateTime _endTime;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _ticker?.cancel();
    _endTime = DateTime.now().add(widget.initialDuration);
    _updateRemaining();
    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateRemaining(),
    );
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final diff = _endTime.difference(now);
    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
    });
    if (_remaining == Duration.zero) {
      _ticker?.cancel();
    }
  }

  String _format(Duration d) {
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mm : $ss';
  }

  bool get _isEnabled => _remaining.inSeconds == 0;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: widget.buttonStyle,
      onPressed: _isEnabled
          ? () {
              widget.onResend();
              // پس از زدن دکمه، شمارش از نو شروع می‌شود
              _startCountdown();
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: _isEnabled
            ? Text('درخواست مجدد کد', style: widget.textStyle)
            : Text(
                '${_format(_remaining)} تا درخواست مجدد کد',
                style: widget.textStyle,
              ),
      ),
    );
  }
}
