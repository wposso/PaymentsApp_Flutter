import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/data/models/Loan.dart';
import 'package:paymentsapp/src/widgets/background_app.dart';
import 'package:paymentsapp/src/widgets/background_card.dart';
import 'package:paymentsapp/src/widgets/card_cuenta_origen.dart';
import 'package:paymentsapp/src/widgets/toolBar_widget.dart';

class DetailLoanPage extends StatefulWidget {
  final Loan? loan;
  const DetailLoanPage({super.key, this.loan});

  @override
  State<DetailLoanPage> createState() => _DetailLoanPageState();
}

class _DetailLoanPageState extends State<DetailLoanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Detalle del prestamo"),
      body: Stack(
        children: <Widget>[
          skinApp(),
          Padding(
            padding: const EdgeInsets.only(
                top: 100.0, bottom: 170.0, left: 20.0, right: 20.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 8.0,
              child: Stack(
                children: <Widget>[
                  backgroundCard(),
                  voucher(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container voucher() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 60.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: widget.loan?.description,
                    style: const TextStyle(
                        color: colorTextoTitulo,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0))
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
              NumberFormat.currency(symbol: '\$ ', decimalDigits: 0)
                  .format(double.parse(widget.loan?.amount ?? '0')),
              style: const TextStyle(
                  color: colorPrimario,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 15.0),
          debitAccount('Deudor', widget.loan?.person.name),
          const SizedBox(height: 10.0),
          const Divider(),
          const SizedBox(height: 10.0),
          RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: 'Transacción realizada el día ',
                style: TextStyle(color: colorTextoSecundario, fontSize: 12.0))
          ])),
          const SizedBox(height: 5.0),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: widget.loan?.dtLoan,
                style: const TextStyle(
                    color: colorTextoTitulo,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0))
          ])),
          const SizedBox(height: 10.0),
          RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: 'Numéro de referencia:',
                style: TextStyle(color: colorTextoSecundario, fontSize: 12.0)),
          ])),
          const SizedBox(height: 5.0),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'PMO # ${widget.loan?.idLoan.toString()}',
                style: const TextStyle(
                    color: colorTextoTitulo,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0)),
          ])),
          const SizedBox(height: 5.0),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Cuota ${widget.loan?.due} de ${widget.loan?.totalDue}',
                style: const TextStyle(
                    color: colorTextoSecundario, fontSize: 12.0))
          ])),
          const SizedBox(height: 15.0),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: widget.loan?.observations,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
                        'Abonar',
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
    );
  }
}
