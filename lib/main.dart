import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paymentsapp/firebase_options.dart';
import 'package:paymentsapp/src/provider/user_provider.dart';
import 'package:paymentsapp/src/router/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'PaymentApp',
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash',
        routes: runway(),
      ),
    );
  }
}
