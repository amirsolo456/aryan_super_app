import 'dart:async';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class CounterDown extends StatefulWidget {
  Duration duration;
  final TextStyle? textStyle;
  final String? untilSendCodeText;
  final AnimationStyle? animationStyle;
  final VoidCallback? onFinished;

  CounterDown({
    super.key,
    required this.duration,
    this.textStyle,
    this.untilSendCodeText,
    this.animationStyle = AnimationStyle.fa,
    this.onFinished,
  });

  @override
  State<CounterDown> createState() => _SimpleCountDownTimerState();
}

class _SimpleCountDownTimerState extends State<CounterDown> {
  var secondsString = "00";
  var minutesString = "00";
  var hoursString = "00";
  var daysString = "00";
  bool _finished = false;

  late Timer timer;

  @override
  void initState() {
    super.initState();

    updateTimerStrings();
    _startTimer();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // بررسی اگر ویجت unmount شده
      if (!mounted) {
        timer.cancel();
        return;
      }

      if ((widget.duration - const Duration(seconds: 1)).isNegative) {
        if (mounted) {
          setState(() {
            _finished = true;
          });
        }
        timer.cancel();
        widget.onFinished?.call();
      } else {
        if (mounted) {
          setState(() {
            widget.duration = widget.duration - const Duration(seconds: 1);
            updateTimerStrings();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateTimerStrings() {
    daysString = widget.duration.inDays.toString().padLeft(2, '0');
    hoursString =
        widget.duration.inHours.remainder(24).toString().padLeft(2, '0');
    minutesString =
        widget.duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    secondsString =
        widget.duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    if (_finished) {
      return InkWell(
        onTap: () {
          // عملیات هنگام کلیک روی Done
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Countdown finished!')),
          );
        },
        child: Text(
          'Done',
          style: widget.textStyle ??
              const TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    }

    // تعیین حالت نمایش بر اساس مدت زمان باقیمانده
    if (daysString != "00") {
      return Container(
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        alignment: Alignment.center,
        child: FaWidget(
          faModel: FaMode.fromDay,
          daysString: daysString,
          hoursString: hoursString,
          minutesString: minutesString,
          secondsString: secondsString,
          textStyle: widget.textStyle,
          animationStyle: widget.animationStyle,
          untilSendCodeText: widget.untilSendCodeText ?? "",
        ),
      );
    }
    if (hoursString != "00") {
      return Container(
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        alignment: Alignment.center,
        child: FaWidget(
          faModel: FaMode.fromHour,
          daysString: daysString,
          hoursString: hoursString,
          minutesString: minutesString,
          secondsString: secondsString,
          textStyle: widget.textStyle,
          animationStyle: widget.animationStyle,
          untilSendCodeText: widget.untilSendCodeText ?? "",
        ),
      );
    }
    if (minutesString != "00") {
      return Container(
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        alignment: Alignment.center,
        child: FaWidget(
          faModel: FaMode.fromMinute,
          daysString: daysString,
          hoursString: hoursString,
          minutesString: minutesString,
          secondsString: secondsString,
          textStyle: widget.textStyle,
          animationStyle: widget.animationStyle,
          untilSendCodeText: widget.untilSendCodeText ?? "",
        ),
      );
    }

    // حالت ثانیه‌ها
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      alignment: Alignment.center,

      child: FaWidget(
        faModel: FaMode.fromSecond,
        daysString: daysString,
        hoursString: hoursString,
        minutesString: minutesString,
        secondsString: secondsString,
        textStyle: widget.textStyle,
        animationStyle: widget.animationStyle,
        untilSendCodeText: widget.untilSendCodeText ?? "",
      ),
    );
  }
}

enum AnimationStyle { fadeIn, basic, fa }
enum FaMode { fromDay, fromHour, fromMinute, fromSecond }

class FaWidget extends StatefulWidget {
  const FaWidget({
    super.key,
    required this.faModel,
    required this.daysString,
    required this.hoursString,
    required this.minutesString,
    required this.secondsString,
    required this.untilSendCodeText,
    this.textStyle,
    this.animationStyle,
  });

  final String untilSendCodeText;
  final FaMode faModel;
  final String daysString;
  final String hoursString;
  final String minutesString;
  final String secondsString;
  final TextStyle? textStyle;
  final AnimationStyle? animationStyle;

  @override
  State<FaWidget> createState() => _FaWidgetState();
}

class _FaWidgetState extends State<FaWidget> {
  @override
  Widget build(BuildContext context) {
    final baseStyle = widget.textStyle ??
        const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        );

    Widget buildAnimatedSeconds(String text) {
      if (widget.animationStyle == AnimationStyle.fa) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },

          child: Text(
            key: ValueKey(text),
            text,
            style: baseStyle,
          ),
        );
      } else {
        return Text(
          text,
          style: baseStyle,
        );
      }
    }

    switch (widget.faModel) {
      case FaMode.fromDay:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${widget.daysString} :", style: baseStyle),
            const SizedBox(width: 4),
            Text("${widget.hoursString} :", style: baseStyle),
            const SizedBox(width: 4),
            Text("${widget.minutesString} :", style: baseStyle),
            const SizedBox(width: 4),
            buildAnimatedSeconds(widget.secondsString),
          ],
        );
      case FaMode.fromHour:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Text("${widget.hoursString} :", style: baseStyle),
            const SizedBox(width: 4),
            Text("${widget.minutesString} :", style: baseStyle),
            const SizedBox(width: 4),
            buildAnimatedSeconds(widget.secondsString),
          ],
        );
      case FaMode.fromMinute:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            Text(": ${widget.minutesString}" + widget.untilSendCodeText,
                style: baseStyle),
            const SizedBox(width: 4),
            buildAnimatedSeconds(widget.secondsString),
          ],
        );
      case FaMode.fromSecond:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            Text(widget.untilSendCodeText, style: baseStyle),
            const SizedBox(width: 4),
            buildAnimatedSeconds(widget.secondsString),
          ],
        );
    }
  }
}