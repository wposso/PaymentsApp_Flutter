import 'package:flutter/material.dart';
import 'package:paymentsapp/src/widgets/background_app.dart';
import 'package:paymentsapp/src/widgets/card_send_widget.dart';

class SendPage extends StatelessWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[skinApp(), const CardSend()],
    ));
  }
}
