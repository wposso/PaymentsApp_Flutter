import 'package:flutter/material.dart';

Widget paymentsEmpty(BuildContext context, String title) {
  final card = Padding(
    padding: const EdgeInsets.all(8),
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50.0),
            Image.asset(
              'assets/nofunds.png',
              width: 150.0,
              height: 150.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  return card;
}
