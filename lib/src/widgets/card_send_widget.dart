import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/widgets/background_card.dart';
import 'package:paymentsapp/src/widgets/card_cuenta_origen.dart';
import 'package:paymentsapp/src/widgets/icon_send_widget.dart';

class CardSend extends StatelessWidget {
  const CardSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 100.0, bottom: 30.0, left: 20.0, right: 20.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 8.0,
        child: Stack(
          children: <Widget>[
            backgroundCard(),
            Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.only(top: 60.0, left: 10.0, right: 10.0),
              child: Column(
                children: <Widget>[
                  iconSend(),
                  const SizedBox(height: 20.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Envio exitoso a ',
                        style: TextStyle(
                            color: colorTextoSecundario, fontSize: 12.0)),
                    TextSpan(
                        text: 'Mamamed Lamon Da',
                        style: TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0))
                  ])),
                  const SizedBox(height: 20.0),
                  const Text('\$ 100.00',
                      style: TextStyle(
                          color: colorPrimario,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15.0),
                  cuentaOrigen(),
                  const SizedBox(height: 10.0),
                  const Divider(),
                  const SizedBox(height: 10.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Transacción realizada el día ',
                        style: TextStyle(
                            color: colorTextoSecundario, fontSize: 12.0))
                  ])),
                  const SizedBox(height: 5.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: '19 de dicimebre de 2023.',
                        style: TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0))
                  ])),
                  const SizedBox(height: 10.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Numéro de referencia: ',
                        style: TextStyle(
                            color: colorTextoSecundario, fontSize: 12.0)),
                  ])),
                  const SizedBox(height: 5.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: '03492390',
                        style: TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0))
                  ])),
                  const SizedBox(height: 30.0),
                  SizedBox(
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          padding: const EdgeInsets.all(0.0),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              transform: GradientRotation(-80),
                              colors: [
                                colorSecundario,
                                colorPrimario,
                              ],
                              begin: FractionalOffset(.18, .9),
                              end: FractionalOffset(.4, -0.2),
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            onTap: () {
                              // Tu código para manejar la acción al hacer clic
                            },
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 300.0,
                                minWidth: 50.0,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Enviar',
                                style: TextStyle(
                                  color: colorTextoBlanco,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
