import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/data/models/pending.dart';
import 'package:paymentsapp/src/widgets/background_app.dart';
import 'package:paymentsapp/src/widgets/toolBar_widget.dart';

class PendingPage extends StatefulWidget {
  const PendingPage({super.key});

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  DateTime? _startDate;
  DateTime? _endDate;

  List<Pending> pendientes = [];
  List<Pending> pendientesFiltered = [];

  @override
  void initState() {
    super.initState();
    pendientes.addAll([
      Pending(
          description: 'netflix',
          date: '2024-01-01',
          amount: '20000',
          dues: '1',
          duesFinal: '12',
          status: 1),
      Pending(
          description: 'tarjeta visa',
          date: '2024-01-02',
          amount: '370000',
          dues: '1',
          duesFinal: '1',
          status: 1),
      Pending(
          description: 'tarjeta amex',
          date: '2024-01-03',
          amount: '500000',
          dues: '1',
          duesFinal: '1',
          status: 1),
      Pending(
          description: 'plan de datos',
          date: '2024-01-04',
          amount: '40000',
          dues: '1',
          duesFinal: '1',
          status: 1)
    ]);
    pendientesFiltered = pendientes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Pagos Pendientes"),
      body: Stack(
        children: <Widget>[
          skinApp(),
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
                            onTap: () => dateFilter(context),
                            child: const CircleAvatar(
                              backgroundColor: colorPrimario,
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
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
                                  itemBuilder: ((context, index) =>
                                      DelayedDisplay(
                                        delay: const Duration(milliseconds: 5),
                                        slidingBeginOffset: const Offset(-1, 0),
                                        fadeIn: true,
                                        child: Card(
                                          child: ListTile(
                                            title: Text(
                                              pendientes[index].date,
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        pendientes[index]
                                                            .amount,
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 30.0),
                                                    Expanded(
                                                      child: Text(
                                                        '${pendientes[index].dues}/${pendientes[index].duesFinal}',
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
                                      ))),
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

  Future<dynamic> dateFilter(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250.0,
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              const Text(
                'Seleccionar fechas',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              ListTile(
                title: Text(_startDate != null
                    ? 'Fecha de inicio: ${_startDate!.toLocal()}'
                    : 'Seleccione fecha de inicio'),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != _startDate) {
                    setState(() {
                      _startDate = picked;
                    });
                  }
                },
              ),
              ListTile(
                title: Text(_endDate != null
                    ? 'Fecha de fin: ${_endDate!.toLocal()}'
                    : 'Seleccione fecha de fin'),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != _endDate) {
                    setState(() {
                      _endDate = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  print('Filtrar por rango de fechas: $_startDate - $_endDate');
                  pendientesFiltered = [];
                  for (var i = 0; i < pendientes.length; i++) {
                    DateTime dt = DateTime.parse(pendientes[i].date);
                    print('Date: $dt in position $i');
                    if (dt.compareTo(_startDate!) >= 0 &&
                        dt.compareTo(_endDate!) <= 0) {
                      pendientesFiltered.add(pendientes[i]);
                    }
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
}
