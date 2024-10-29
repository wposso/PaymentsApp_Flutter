import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';

Widget circulo1() {
  final circulo1 = Container(
    height: 150.0,
    width: 150.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0),
        color: colorCirculo.withOpacity(0.3)),
  );

  return circulo1;
}

Widget circulo2() {
  final circulo2 = Container(
    height: 100.0,
    width: 100.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0),
        color: colorCirculo.withOpacity(0.3)),
  );
  return circulo2;
}

Widget circulo3() {
  final circulo3 = Container(
    height: 150.0,
    width: 150.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0),
        color: colorCirculo1.withOpacity(0.3)),
  );

  return circulo3;
}

Widget circulo4() {
  final circulo4 = Container(
    height: 100.0,
    width: 100.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0),
        color: colorCirculo1.withOpacity(0.3)),
  );
  return circulo4;
}
