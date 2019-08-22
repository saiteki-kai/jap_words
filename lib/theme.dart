import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color appBarTitle = const Color(0xFFFFFFFF);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);
  static const Color appBarGradientStart = const Color(0xFF43CEA2);
  static const Color appBarGradientEnd = const Color(0xFF185A9D);

  static const Color card = const Color(0xFF315173);
  static const Color title = const Color(0xFFFFFFFF);
  static const Color subtitle = const Color(0xEEFFFFFF);
  static const Color header = const Color(0xEEFFFFFF);
  static const Color common = const Color(0xFFFFFFFF);
  static const Color button = const Color(0xFFFFBF69);
  static const Color icon = const Color(0xFFFFFFFF);

  static const Color tag = const Color(0xFF4CAF50);
  static const Color accent = const Color(0xFF69F0AE);
  static const Color highlight = const Color(0xFFFFFF00);
}

class Dimens {
  const Dimens();

  //static const planetWidth = 100.0;
  //static const planetHeight = 100.0;
}

class TextStyles {
  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
    color: Colors.appBarTitle,
    //fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
  );

  static const TextStyle title = const TextStyle(
    color: Colors.title,
    //fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 42.0,
  );

  static const TextStyle subtitle = const TextStyle(
    color: Colors.subtitle,
    //fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    fontSize: 18.0,
  );

  static const TextStyle header = const TextStyle(
    color: Colors.header,
    //fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    fontSize: 20.0,
  );

  static const TextStyle common = const TextStyle(
    color: Colors.common,
    //fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    fontSize: 16.0,
  );
}
