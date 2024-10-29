import 'dart:convert';
import 'package:paymentsapp/src/data/models/Deposit.dart';

List<Deposit> depositsFromMap(String str) =>
    List<Deposit>.from(json.decode(str).map((x) => Deposit.fromMap(x)));

String depositsToMap(List<Deposit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
