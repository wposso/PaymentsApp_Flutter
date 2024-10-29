import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';

final GlobalKey<AnimatedCircularChartState> _chartKey =
    GlobalKey<AnimatedCircularChartState>();

Widget cardCondicion(BuildContext context, String name) {
  final card = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                circularChart(),
                const SizedBox(width: 5.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Hola, $name',
                        style: const TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                    const Text(
                      'Este es tu resumen financiero',
                      style: TextStyle(color: colorTextoSecundario),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 12.0),
            const Divider(height: .5),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'movements');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Ver Movimientos',
                      style: TextStyle(
                        color: colorPrimario,
                        fontWeight: FontWeight.w700,
                      )),
                  Icon(Icons.keyboard_arrow_right, color: colorPrimario),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );

  return card;
}

Widget circularChart() {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: 35.0,
        height: 35.0,
        decoration: BoxDecoration(
            color: colorPrimario, borderRadius: BorderRadius.circular(25.0)),
      ),
      AnimatedCircularChart(
        holeRadius: 18.0,
        key: _chartKey,
        size: const Size(55.0, 55.0),
        initialChartData: <CircularStackEntry>[
          CircularStackEntry(<CircularSegmentEntry>[
            const CircularSegmentEntry(80.0, colorPrimario,
                rankKey: 'completado'),
            CircularSegmentEntry(20.0, colorCirculo.withOpacity(.7),
                rankKey: 'resto')
          ], rankKey: 'progreso')
        ],
        chartType: CircularChartType.Radial,
        percentageValues: true,
        holeLabel: '80',
        labelStyle: const TextStyle(
            color: colorTextoBlanco,
            fontWeight: FontWeight.w500,
            fontSize: 18.0),
      )
    ],
  );
}
