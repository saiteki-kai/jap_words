import 'dart:math';

import 'package:flutter/material.dart';

class StepItem extends StatelessWidget {
  const StepItem({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.active,
  }) : super(key: key);

  final String title, subtitle;
  final bool active;

  @override
  Widget build(BuildContext context) {
    var percent = Random.secure().nextDouble() * 100;
    var col = Random.secure().nextInt(4);

    final borderSide = BorderSide(
      width: 2,
      color: Colors.orangeAccent,
      style: BorderStyle.solid,
    );

    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: active ? Colors.orange[600] : Colors.orange[col * 100],
        border: BorderDirectional(
          // TODO: gestire bordi da fuori nella classe Cell?
          top: borderSide,
          start: borderSide,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Container buildContainer(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      width: 100,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildExpanded() {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        subtitle,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
