import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';

Widget total(String total) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Saldo disponible',
            style: TextStyle(color: colorTextoBlanco)),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('\$ $total',
                style: const TextStyle(
                    color: colorTextoBlanco,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(width: 10.0),
            SizedBox(
                height: 20.0,
                width: 65.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: colorSecundario,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_up,
                          color: Colors.white, size: 20.0),
                      Text('15%', style: TextStyle(color: colorTextoBlanco)),
                    ],
                  ),
                ))
          ],
        )
      ],
    ),
  );
}
