import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(
      // fontFamily: 'Poppins',
      );

  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 14.0,
  );

  static final coloredTextStyle = baseTextStyle.copyWith(
    color: const Color(0xffb6b2df),
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static final commonTextStyle = baseTextStyle.copyWith(
    fontSize: 16.0,
    color: Colors.white,
  );

  static final titleTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 42.0,
    fontWeight: FontWeight.w600,
  );

  static final headerTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );
}
