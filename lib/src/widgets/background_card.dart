import 'package:flutter/material.dart';
import 'package:paymentsapp/src/widgets/circulos_widget.dart';

Widget backgroundCard() {
  return SizedBox(
    width: 350.0,
    height: 455.0,
    child: Stack(
      children: <Widget>[
        Positioned(left: -80.0, top: -80.0, child: circulo1()),
        Positioned(right: -90.0, bottom: -90.0, child: circulo1())
      ],
    ),
  );
}
