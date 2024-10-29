import 'package:cloud_firestore/cloud_firestore.dart';

class Balance {
  double? balance;
  double? debts;
  double? deposits;
  double? expenses;
  double? loans;
  double? payments;

  Balance(
      {this.balance,
      this.debts,
      this.deposits,
      this.expenses,
      this.loans,
      this.payments});

  factory Balance.fromMap(Map<String, dynamic> json) => Balance(
      balance: json['balance'],
      debts: json['debts'],
      deposits: json['deposits'],
      expenses: json['expenses'],
      loans: json['loans'],
      payments: json['payments']);

  Map<String, dynamic> toMap() => {
        "balance": balance,
        "debts": debts,
        "deposits": deposits,
        "expenses": expenses,
        "loans": loans,
        "payments": payments
      };

  static Balance fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Balance(
        balance: data['balance'],
        debts: data['debts'],
        deposits: data['deposits'],
        expenses: data['expenses'],
        loans: data['loans'],
        payments: data['payments']);
  }
}
