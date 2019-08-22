import 'package:flutter/material.dart';
import 'package:nihongo_courses/theme.dart' as Theme;

class HighlightedText extends StatelessWidget {
  final String text;
  final Color color, highlightColor;

  HighlightedText(this.text, this.color, this.highlightColor);

  @override
  Widget build(BuildContext context) {
    var split = text.split(RegExp("</?b>"));

    var list = <TextSpan>[];
    for (var i = 0; i < split.length; i++) {
      list.add(
        TextSpan(
          text: split[i],
          style: TextStyle(
            fontWeight: i == 1 ? FontWeight.bold : FontWeight.normal,
            color: i == 1 ? highlightColor : color,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(text: "", children: list, style: Theme.TextStyles.header),
    );
  }
}
