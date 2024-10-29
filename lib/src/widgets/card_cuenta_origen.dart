import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';

Widget cuentaOrigen() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircleAvatar(
        maxRadius: 20.0,
        backgroundImage: AssetImage('assets/yo.jpg'),
      ),
      SizedBox(width: 10.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Felipe Montoya',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
          Text('mail@mail.com',
              style: TextStyle(color: colorTextoSecundario, fontSize: 11.0))
        ],
      )
    ],
  );
}

Widget debitAccount(String title, String? idDebit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const CircleAvatar(
        maxRadius: 20.0,
        backgroundImage: AssetImage('assets/user.png'),
      ),
      const SizedBox(width: 10.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style:
                  const TextStyle(color: colorTextoSecundario, fontSize: 11.0)),
          Text(idDebit!,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0))
        ],
      )
    ],
  );
}
