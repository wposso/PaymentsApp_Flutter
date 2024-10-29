import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/widgets/circulos_widget.dart';

Widget skinApp() {
  final fondo = Container(
    color: colorPrimario,
    width: double.infinity,
    height: double.infinity,
  );

  return Stack(
    children: <Widget>[
      fondo,
      Positioned(left: -50.0, top: -65.0, child: circulo1()),
      Positioned(right: -25.0, top: -48.0, child: circulo2())
    ],
  );
}

Widget skinHome() {
  final boxTop = Container(
    height: 220.0,
    width: double.infinity,
    color: colorPrimario,
  );

  return Stack(
    children: <Widget>[
      boxTop,
      Positioned(left: -50.0, top: -65.0, child: circulo1()),
      Positioned(right: -25.0, top: -48.0, child: circulo2())
    ],
  );
}

Widget skinScreen(Color? skin) {
  final fondo = Container(
    color: skin,
    width: double.infinity,
    height: double.infinity,
  );

  return Stack(
    children: <Widget>[
      fondo,
      Positioned(left: -50.0, top: -65.0, child: circulo3()),
      Positioned(right: -25.0, top: -48.0, child: circulo4())
    ],
  );
}
