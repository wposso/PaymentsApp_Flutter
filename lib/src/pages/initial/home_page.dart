import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/data/models/Balance.dart';
import 'package:paymentsapp/src/data/models/Person.dart';
import 'package:paymentsapp/src/provider/user_provider.dart';
import 'package:paymentsapp/src/services/firebase_services.dart';
import 'package:paymentsapp/src/widgets/appbar_widget.dart';
import 'package:paymentsapp/src/widgets/background_app.dart';
import 'package:paymentsapp/src/widgets/card_condition_widget.dart';
import 'package:paymentsapp/src/widgets/cards_detail_widget.dart';
import 'package:paymentsapp/src/widgets/total_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return FutureBuilder<List<dynamic>>(
          future: Future.wait(
              [_fetchUserData(userProvider), _fetchBalance(userProvider)]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingIndicator();
            } else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                Person? userData = snapshot.data?[0];
                Balance? balanceData = snapshot.data?[1];
                String name =
                    userProvider.user?.displayName ?? userData?.name ?? '';
                String balance = balanceData?.balance.toString() ?? '0';
                return Scaffold(
                  body: Stack(
                    children: <Widget>[
                      skinHome(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          appBar(),
                          total(balance),
                          const SizedBox(height: 15.0),
                          cardCondicion(context, name),
                          const SizedBox(height: 10.0),
                          const CardsDetail(),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }
          },
        );
      },
    );
  }

  /*Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                'Cargando información del usuario...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _buildLoadingIndicator() {
    return Container(
      color: colorPrimario,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(colorSecundario),
            ),
            SizedBox(height: 12),
            Text(
              'Cargando información del usuario...',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Person?> _fetchUserData(UserProvider userProvider) async {
    String? uid = userProvider.user?.uid;
    if (uid != null) {
      return await getUserData(uid);
    } else {
      return null;
    }
  }

  Future<Balance?> _fetchBalance(UserProvider userProvider) async {
    String? uid = userProvider.user?.uid;
    if (uid != null) {
      return await getUserBalance(uid);
    } else {
      return null;
    }
  }
}
