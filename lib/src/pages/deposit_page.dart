import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/data/models/Deposit.dart';
import 'package:paymentsapp/src/provider/user_provider.dart';
import 'package:paymentsapp/src/services/firebase_services.dart';
import 'package:paymentsapp/src/utils/thousands_formatter.dart';
import 'package:paymentsapp/src/utils/utils.dart';
import 'package:paymentsapp/src/widgets/background_app.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:paymentsapp/src/widgets/icon_page.dart';
import 'package:paymentsapp/src/widgets/toolBar_widget.dart';
import 'package:provider/provider.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  DateTime _selectedDate = currentDay();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
    return Scaffold(
      appBar: CustomAppBar(title: "Ingresos"),
      body: Stack(
        children: <Widget>[
          skinScreen(colorPrimario),
          iconPage(160.0, 'assets/pagar1.png', colorPrimario),
          Padding(
            padding: const EdgeInsets.only(
                top: 160.0, bottom: 0.0, left: 0.0, right: 0.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 8.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 10.0, right: 10.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: GestureDetector(
                            onTap: () =>
                                _showDatePicker(context, _selectedDate),
                            child: TextField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Fecha',
                                suffixIcon: GestureDetector(
                                  onTap: () =>
                                      _showDatePicker(context, _selectedDate),
                                  child: const Icon(Icons.calendar_today),
                                ),
                              ),
                              readOnly: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Descripción',
                              suffixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              ThousandsFormatter(),
                            ],
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Valor',
                              suffixIcon: Icon(Icons.monetization_on_rounded),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: TextField(
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            controller: _observationsController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Observaciones',
                            ),
                          ),
                        ),
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
                                  onTap: () async {
                                    Deposit? deposit;
                                    deposit = Deposit(
                                        id: 0,
                                        dtDeposit: _dateController.text,
                                        description:
                                            _descriptionController.text,
                                        amount: _amountController.text,
                                        observations:
                                            _observationsController.text,
                                        status: 1);

                                    if (deposit.description?.isNotEmpty ==
                                            true &&
                                        deposit.amount?.isNotEmpty == true) {
                                      print(jsonEncode(deposit.toMap()));
                                      await saveDeposit(context, deposit)
                                          .then((_) => {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      '¡Depósito guardado correctamente!',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    duration:
                                                        Duration(seconds: 3),
                                                    backgroundColor:
                                                        colorPrimario,
                                                  ),
                                                )
                                              });
                                      /*Future<double> sum = getBalanceUpdated(
                                              double.tryParse(
                                                      deposit.amount!) ??
                                                  0.0 // Si el parsing falla, usa 0.0 como valor por defecto
                                              )
                                          .then((value) {
                                        updateDeposit(
                                            context, value.toDouble(), uid);
                                      });*/
                                      getBalanceUpdated(double.tryParse(
                                                  deposit.amount!) ??
                                              0.0)
                                          .then((value) {
                                        double sum = value.toDouble();
                                        updateDeposit(context, sum, uid);
                                      });

                                      _dateController.clear();
                                      _descriptionController.clear();
                                      _amountController.clear();
                                      _observationsController.clear();
                                      setState(() {});
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            'Hay campos requeridos vacios',
                                            textAlign: TextAlign.center,
                                          ),
                                          duration: const Duration(seconds: 3),
                                          backgroundColor: colorSkin3,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 300.0,
                                      minWidth: 50.0,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Guardar',
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
          ),
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext ctx, DateTime selectedDate) async {
    final DateTime? picked = await showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 280,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    selectedDate = newDateTime;
                  });
                },
              ),
            ),
            CupertinoButton(
              child: const Text('SELECCIONAR'),
              onPressed: () {
                setState(() {
                  _selectedDate = selectedDate;
                  _dateController.text =
                      DateFormat('dd-MM-yyyy').format(_selectedDate);
                });
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      ),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
      });
    }
  }
}
