import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/widgets/card_movements_detail.dart';
import 'package:paymentsapp/src/widgets/circulos_widget.dart';

class DetailMovementsPage extends StatelessWidget {
  const DetailMovementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[_fondo(), const MovementDetail()],
    ));
  }

  Widget _fondo() {
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
}
