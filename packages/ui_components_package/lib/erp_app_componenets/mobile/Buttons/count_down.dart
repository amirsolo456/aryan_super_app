import 'package:flutter/material.dart';
import 'package:resources_package/Resources/Styles/font_size.dart';
import 'count_down_style.dart';

class ClickableCountDown extends StatefulWidget {
  final Duration duration;
  final String finishedText;
  final String untilFinishedText;
  final VoidCallback? onFinishedClick;

  const ClickableCountDown({
    super.key,
    required this.duration,
    this.finishedText = "ارسال دوباره",
    this.untilFinishedText = "تا ارسال دوباره",
    this.onFinishedClick,
  });

  @override
  State<ClickableCountDown> createState() => _ClickableCountDownState();
}

class _ClickableCountDownState extends State<ClickableCountDown> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: 60,
      alignment: Alignment.center,
      child: isFinished
          ? GestureDetector(
        onTap: widget.onFinishedClick,
        child: Text(
          widget.finishedText,
          style: const TextStyle(
            color: Color(0XFFB1B1B1),
            fontSize: AryanSizes.mediumFont14,
            backgroundColor: Colors.transparent,
          ),
        ),
      )
          : CounterDown(
        duration: widget.duration,
        untilSendCodeText: widget.untilFinishedText,
        textStyle: const TextStyle(
          color: Colors.black54,
          fontSize: AryanSizes.mediumFont14,
          backgroundColor: Colors.transparent,
        ),
        onFinished: () {
          setState(() {
            isFinished = true;
          });
        },
      ),
    );
  }
}