import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/data/models/Loan.dart';
import 'package:paymentsapp/src/pages/loans/detail_loan_page.dart';
import 'package:paymentsapp/src/services/firebase_services.dart';
import 'package:paymentsapp/src/utils/utils.dart';
import 'package:paymentsapp/src/widgets/background_app.dart';
import 'package:paymentsapp/src/widgets/empty_payments.dart';
import 'package:paymentsapp/src/widgets/icon_page.dart';
import 'package:paymentsapp/src/widgets/toolBar_widget.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  List<Loan> allLoans = [];
  List<Loan> filteredLoans = [];

  @override
  void initState() {
    super.initState();
    fetchLoans();
  }

  Future<void> fetchLoans() async {
    try {
      allLoans = await getLoans();
      setState(() {});
    } catch (error) {
      print('Error al cargar los datos: $error');
    }
  }

  void filterDebits(String selectedDebit) {
    setState(() {
      filteredLoans =
          allLoans.where((loan) => loan.person.name == selectedDebit).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Prestamos"),
      body: Stack(
        children: <Widget>[
          skinScreen(skinLoan),
          iconPage(120.0, 'assets/icon_loans.png', skinLoan),
          Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 8.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.pushNamed(
                                      context, '/frmLoan');
                                  setState(() {});
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: colorPrimario,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          flex: 3,
                          child: filteredLoans.isEmpty
                              ? paymentsEmpty(
                                  context, 'No tiene prestamos pendientes')
                              : FutureBuilder(
                                  future: getLoans(),
                                  builder: ((context, snapshot) {
                                    List<Loan>? loans = snapshot.data;
                                    return ListView.builder(
                                        itemCount: snapshot.data?.length,
                                        itemBuilder: (context, index) {
                                          Loan loan = loans![index];
                                          if (snapshot.hasData) {
                                            return DelayedDisplay(
                                              //delay: const Duration(milliseconds: 5),
                                              //slidingBeginOffset: const Offset(-1, 0),
                                              fadeIn: true,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailLoanPage(
                                                              loan: loan),
                                                    ),
                                                  );
                                                  /*Navigator.pushNamed(
                                                      context, 'detailLoan',
                                                      arguments: {loan});*/
                                                },
                                                child: Card(
                                                  child: ListTile(
                                                    title: Text(
                                                      loan.dtLoan,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    leading:
                                                        const Icon(Icons.timer),
                                                    trailing: Icon(
                                                      Icons.delete,
                                                      color:
                                                          Colors.red.shade900,
                                                    ),
                                                    subtitle: Column(
                                                      children: [
                                                        Text(
                                                          loan.description,
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        Text(
                                                          loan.person.name ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                formatAmount(
                                                                    loan.amount),
                                                                /*style: const TextStyle(
                                                        color: colorPrimario,
                                                        fontSize: 26.0,
                                                        fontWeight: FontWeight.bold)*/
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 30.0),
                                                            Expanded(
                                                              child: Text(
                                                                '${loan.due}"/"${loan.totalDue}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        });
                                  }),
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
                                        text: 'Dinero prestado: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                    TextSpan(
                                        text: formatAmount('3500000'),
                                        style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                  ])),
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

  void showDebitsFilter(BuildContext context, List<String> debits) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            String? _selectedDebit;
            return SizedBox(
              height: 250.0,
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  const Text(
                    'Seleccione el adeudado',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 10.0),
                    child: DropdownButton<String>(
                      hint:
                          const Text('Seleccione', textAlign: TextAlign.center),
                      isExpanded: true,
                      value: _selectedDebit,
                      items: debits.map((newValue) {
                        return DropdownMenuItem<String>(
                          value: newValue,
                          child: Text(newValue),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDebit = newValue;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, _selectedDebit);
                    },
                    child: const Text('Filtrar'),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((selectedDebit) {
      if (selectedDebit != null) {
        filterDebits(selectedDebit);
      }
    });
  }

  Future<void> debitsFilter(BuildContext context) async {
    try {
      List<String> debits = await getDebtorLoans();
      showDebitsFilter(context, debits);
    } catch (error) {
      // Maneja el error aquí, si es necesario
      print('Error al cargar los datos: $error');
    }
  }
}
