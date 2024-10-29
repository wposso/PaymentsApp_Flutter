import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/data/models/Liability.dart';
import 'package:paymentsapp/src/pages/liabilities/detail_liability_page.dart';
import 'package:paymentsapp/src/widgets/circulos_widget.dart';
import 'package:paymentsapp/src/widgets/toolBar_widget.dart';

class LiabilitiesPage extends StatefulWidget {
  const LiabilitiesPage({super.key});

  @override
  State<LiabilitiesPage> createState() => _LiabilitiesPageState();
}

class _LiabilitiesPageState extends State<LiabilitiesPage> {
  List<Liability> pendientes = [];
  List<Liability> pendientesFiltered = [];

  @override
  void initState() {
    super.initState();
    pendientes.addAll([
      Liability(
          idLibiality: 1,
          idDebit: 'Laura Zuluaga',
          dtLiability: '2024-01-15',
          description: 'netflix',
          amount: '20000',
          observations: 'Cuota # 1',
          status: 1),
      Liability(
          idLibiality: 1,
          idDebit: 'Martha',
          dtLiability: '2024-01-15',
          description: 'parqueadero',
          amount: '35000',
          observations: 'Cuota # 1',
          status: 1),
      Liability(
          idLibiality: 1,
          idDebit: 'Bancolombia',
          dtLiability: '2024-01-15',
          description: 'materiales',
          amount: '325000',
          observations: 'Cuota # 1',
          status: 1),
      Liability(
          idLibiality: 1,
          idDebit: 'Bancolombia',
          dtLiability: '2024-01-15',
          description: 'mano de obra',
          amount: '200000',
          observations: 'Cuota # 1',
          status: 1)
    ]);
    pendientesFiltered = pendientes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Deudas"),
      body: Stack(
        children: <Widget>[
          _fondo(),
          _iconPage(),
          Padding(
            padding: const EdgeInsets.only(
                top: 200.0, bottom: 0.0, left: 0.0, right: 0.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 8.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    //alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: InkWell(
                            onTap: () => debitsFilter(context),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  backgroundColor: colorPrimario,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          flex: 3,
                          child: pendientesFiltered.isEmpty
                              ? _paymentsEmpty(context)
                              : ListView.builder(
                                  itemCount: pendientes.length,
                                  itemBuilder: (context, index) =>
                                      DelayedDisplay(
                                    //delay: const Duration(milliseconds: 5),
                                    //slidingBeginOffset: const Offset(-1, 0),
                                    fadeIn: true,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailLiabilityPage(
                                                    liability:
                                                        pendientes[index]),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        child: ListTile(
                                          title: Text(
                                            pendientes[index].dtLiability,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          leading: const Icon(Icons.timer),
                                          trailing: Icon(
                                            Icons.delete,
                                            color: Colors.red.shade900,
                                          ),
                                          subtitle: Column(
                                            children: [
                                              Text(
                                                pendientes[index].description,
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                pendientes[index].idDebit,
                                                textAlign: TextAlign.left,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      NumberFormat.currency(
                                                              symbol: '\$ ',
                                                              decimalDigits: 0)
                                                          .format(double.parse(
                                                              pendientes[index]
                                                                  .amount)),
                                                      /*style: const TextStyle(
                                                        color: colorPrimario,
                                                        fontSize: 26.0,
                                                        fontWeight: FontWeight.bold)*/
                                                    ),
                                                  ),
                                                  const SizedBox(width: 30.0),
                                                  const Expanded(
                                                    child: Text(
                                                      '1/12',
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    const TextSpan(
                                        text: 'TOTAL: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                    TextSpan(
                                        text: '\$ 2.500.000',
                                        style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                  ])),
                                ],
                              ),
                              const SizedBox(width: 30.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      /*Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailLiabilityPage(
                                                    liability:
                                                        pendientesFiltered),
                                          ),
                                      );*/
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorPrimario,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Establecer el radio del borde a 0 para eliminar el redondeo
                                      ),
                                    ),
                                    child: const Text(
                                      'Pagar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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

  Padding _paymentsEmpty(BuildContext context) {
    return Padding(
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
              const Text(
                'No tienes pagos pendientes',
                style: TextStyle(
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
  }

  Future<dynamic> debitsFilter(BuildContext context) {
    List<String> _debits = ['Laura', 'Martha', 'Bancolombia'];
    String? _selectedDebit;

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250.0,
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              const Text(
                'Seleccione el adeudado',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              //textview
              //dropdown
              //usuario
              Padding(
                padding: const EdgeInsets.only(
                    left: 50.0, right: 50.0, bottom: 10.0, top: 10.0),
                child: DropdownButton(
                  hint: const Text(
                    'Seleccione',
                    textAlign: TextAlign.center,
                  ), // Not necessary for Option 1
                  isExpanded: true,
                  value: _selectedDebit,
                  items: _debits.map((newValue) {
                    return DropdownMenuItem(
                      value: newValue,
                      child: Text(newValue),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedDebit = newValue;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  pendientesFiltered = [];
                  for (var i = 0; i < pendientes.length; i++) {
                    setState(() {});
                  }
                  Navigator.pop(context);
                },
                child: const Text('Filtrar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _fondo() {
    final fondo = Container(
      color: colorSkin3,
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

  Row _iconPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 200.0),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50.0,
          child: Image.asset(
            'assets/compartir.png',
            color: colorSkin3,
            width: 50.0,
            height: 50.0,
          ),
        ),
      ],
    );
  }
}
