import 'package:flutter/material.dart';

class HtmlTextParserWidget extends StatelessWidget {
  final String text;
  final TextStyle defaultStyle;
  final TextAlign textAlign;

  const HtmlTextParserWidget({
    Key? key,
    required this.text,
    this.defaultStyle = const TextStyle(
      fontFamily: 'IRANSansRegular',
      package: '/packages/resources_package',
      fontSize: 14,
      color: Colors.black,
    ),
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(style: defaultStyle, children: _parseText(text)),
    );
  }

  List<TextSpan> _parseText(String input) {
    List<TextSpan> spans = [];
    String remaining = input;

    final regex = RegExp(
      r'(\[b\](.*?)\[/b\]|\[color=(.*?)\](.*?)\[/color\])',
      dotAll: true,
    );

    while (remaining.isNotEmpty) {
      final match = regex.firstMatch(remaining);

      if (match == null) {
        spans.add(TextSpan(text: remaining, style: defaultStyle));
        break;
      }

      // متن قبل از match
      if (match.start > 0) {
        spans.add(
          TextSpan(
            text: remaining.substring(0, match.start),
            style: defaultStyle,
          ),
        );
      }

      // بررسی نوع tag
      if (match.group(1)!.startsWith('[b]')) {
        spans.add(
          TextSpan(
            text: match.group(2), // متن داخل [b][/b]
            style: defaultStyle.merge(
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        );
      } else if (match.group(1)!.startsWith('[color=')) {
        Color parsedColor = _colorFromString(match.group(3) ?? '');
        spans.add(
          TextSpan(
            text: match.group(4), // متن داخل [color][/color]
            style: defaultStyle.merge(TextStyle(color: parsedColor)),
          ),
        );
      }

      remaining = remaining.substring(match.end);
    }

    return spans;
  }

  Color _colorFromString(String color) {
    switch (color.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.black;
    }
  }
}
