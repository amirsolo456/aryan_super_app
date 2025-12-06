import 'package:flutter/material.dart';

class HtmlTextParserWidget extends StatelessWidget {
  final String text;
  final TextStyle defaultStyle;
  final TextAlign textAlign;

  /// اگر مقدار bracketReplacement مشخص شود،
  /// همه occurrences از الگوی [....] با آن مقدار جایگزین می‌شوند.
  final String? bracketReplacement;

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
    this.bracketReplacement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final processed = bracketReplacement != null
        ? replaceAllBrackets(text, bracketReplacement!)
        : text;

    return RichText(
      textAlign: textAlign,
      text: TextSpan(style: defaultStyle, children: _parseText(processed)),
    );
  }

  /// --- utility: جایگزینی همه [... ] با مقدار replacement ---
  static String replaceAllBrackets(String template, String replacement) {
    return template.replaceAll(RegExp(r'\[.*?\]'), replacement);
  }

  /// اگر فقط اولین براکت را بخواهید جایگزین کنید:
  static String replaceFirstBracket(String template, String replacement) {
    return template.replaceFirst(RegExp(r'\[.*?\]'), replacement);
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

      if (match.start > 0) {
        spans.add(
          TextSpan(
            text: remaining.substring(0, match.start),
            style: defaultStyle,
          ),
        );
      }

      if (match.group(1)!.startsWith('[b]')) {
        spans.add(
          TextSpan(
            text: match.group(2),
            style: defaultStyle.merge(
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        );
      } else if (match.group(1)!.startsWith('[color=')) {
        Color parsedColor = _colorFromString(match.group(3) ?? '');
        spans.add(
          TextSpan(
            text: match.group(4),
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
