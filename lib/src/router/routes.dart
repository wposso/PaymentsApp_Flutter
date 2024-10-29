import 'package:flutter/material.dart';
import 'package:paymentsapp/src/pages/deposit_page.dart';
import 'package:paymentsapp/src/pages/discharge_page.dart';
import 'package:paymentsapp/src/pages/egress_page.dart';
import 'package:paymentsapp/src/pages/initial/home_page.dart';
import 'package:paymentsapp/src/pages/initial/recover_password_page.dart';
import 'package:paymentsapp/src/pages/initial/register_page.dart';
import 'package:paymentsapp/src/pages/liabilities/libialities_page.dart';
import 'package:paymentsapp/src/pages/loans/frm_loan_page.dart';
import 'package:paymentsapp/src/pages/loans/loans_page.dart';
import 'package:paymentsapp/src/pages/initial/login_page.dart';
import 'package:paymentsapp/src/pages/movements/movements_page.dart';
import 'package:paymentsapp/src/pages/pending_page.dart';
import 'package:paymentsapp/src/pages/send_page.dart';
import 'package:paymentsapp/src/pages/initial/splash_screen.dart';

Map<String, WidgetBuilder> runway() {
  return {
    'splash': (BuildContext context) => const SplashScreen(),
    'login': (BuildContext context) => const LoginPage(),
    'register': (BuildContext context) => const RegisterPage(),
    'reset': (BuildContext context) => const RecoverPasswordPage(),
    'home': (BuildContext context) => const HomePage(),
    'deposit': (BuildContext context) => const DepositPage(),
    'egress': (BuildContext context) => const EgressPage(),
    'send': (BuildContext context) => const SendPage(),
    'pay': (BuildContext context) => const DischargePage(),
    'movements': (BuildContext context) => const MovementsPage(),
    'pending': (BuildContext context) => const PendingPage(),
    'liabilities': (BuildContext context) => const LiabilitiesPage(),
    'loans': (BuildContext context) => const LoansPage(),
    '/frmLoan': (BuildContext context) => const FrmLoanPage(),
  };
}
