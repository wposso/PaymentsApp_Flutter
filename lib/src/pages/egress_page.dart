import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/widgets/circulos_widget.dart';
import 'package:paymentsapp/src/widgets/toolBar_widget.dart';

class EgressPage extends StatefulWidget {
  const EgressPage({super.key});

  @override
  State<EgressPage> createState() => _EgressPageState();
}

class _EgressPageState extends State<EgressPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final NumberFormat _currencyFormatter =
      NumberFormat.currency(symbol: '', decimalDigits: 0);
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
    return Scaffold(
      appBar: CustomAppBar(title: "Egresos"),
      body: Stack(
        children: <Widget>[
          _fondo(),
          _iconPage(),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
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
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: TextField(
                            decoration: InputDecoration(
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
                            controller: _valorController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                final numericValue =
                                    int.tryParse(newValue.text.trim());
                                if (numericValue != null) {
                                  final formattedValue =
                                      formatCurrency(numericValue);
                                  _valorController.value = TextEditingValue(
                                    text: formattedValue,
                                    selection: TextSelection.collapsed(
                                        offset: formattedValue.length),
                                  );
                                }
                                return _valorController.value;
                              }),
                            ],
                            onChanged: (value) {
                              // Aquí puedes realizar acciones adicionales cuando el valor cambia
                              _valorController.text = value;
                              final numericValue = int.tryParse(value);
                              if (numericValue != null) {
                                final formattedValue =
                                    _currencyFormatter.format(numericValue);
                                _valorController.value = TextEditingValue(
                                  text: formattedValue,
                                  selection: TextSelection.collapsed(
                                      offset: formattedValue.length),
                                );
                              }
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Valor',
                              suffixIcon: Icon(Icons.monetization_on_rounded),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          child: TextField(
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Observaciones',
                              // Puedes agregar un icono al final, si lo deseas
                              //suffixIcon: Icon(Icons.), // Reemplaza 'your_icon' con el icono que deseas
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
          )
        ],
      ),
    );
  }

  Row _iconPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 200.0),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50.0,
          child: Image.asset(
            'assets/cards.png',
            color: colorSkin2,
            width: 200.0,
            height: 200.0,
          ),
        ),
      ],
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
            // Close the modal
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

  Widget _fondo() {
    final fondo = Container(
      color: colorSkin2,
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

  String formatCurrency(int value) {
    final formattedValue = _currencyFormatter.format(value);
    return formattedValue.trim();
  }
}
