import 'package:flutter/material.dart';

Widget iconPage(double high, String img, Color? colorSkin) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(height: high),
      CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50.0,
        child: Image.asset(
          img,
          color: colorSkin,
          width: 50.0,
          height: 50.0,
        ),
      ),
    ],
  );
}
