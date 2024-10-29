import 'package:intl/intl.dart';

String formatAmount(String amount) {
  return NumberFormat.currency(symbol: '\$ ', decimalDigits: 0)
      .format(double.parse(amount));
}

String currentMoney(int amount) {
  return NumberFormat.currency(symbol: '', locale: 'es_CO', decimalDigits: 0)
      .format(amount);
}

DateTime currentDay() {
  return DateTime.now();
}
