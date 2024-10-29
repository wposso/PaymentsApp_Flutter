import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/pages/movements/detail_movements_page.dart';
import 'package:paymentsapp/src/services/firebase_services.dart';
import 'package:paymentsapp/src/widgets/toolBar_widget.dart';

class MovementsPage extends StatelessWidget {
  const MovementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tam = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(title: "Movimientos"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: tam.height, // ajusta según tus necesidades
                  child: FutureBuilder(
                    future: getLiabilities(),
                    builder: ((context, snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.hasData) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DetailMovementsPage(),
                                  ),
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        snapshot.data?[index]['isMonetization']
                                            ? Icons.monetization_on
                                            : Icons.money_off,
                                        size: 30,
                                        color: colorPrimario,
                                      ),
                                      const SizedBox(width: 5.0),
                                      Text(snapshot.data?[index]['nombre']),
                                      const SizedBox(width: 30),
                                      Text(snapshot.data?[index]['monto']),
                                      const SizedBox(width: 30),
                                      Text(snapshot.data?[index]['fecha']),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
