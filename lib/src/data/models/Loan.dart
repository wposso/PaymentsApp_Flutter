import 'package:paymentsapp/src/data/models/Person.dart';

class Loan {
  int idLoan;
  Person person;
  String dtLoan;
  String description;
  String amount;
  String observations;
  String due;
  String totalDue;
  String action;
  int status;

  Loan({
    required this.idLoan,
    required this.person,
    required this.dtLoan,
    required this.description,
    required this.amount,
    required this.observations,
    required this.due,
    required this.totalDue,
    required this.action,
    required this.status,
  });

  factory Loan.fromMap(Map<String, dynamic> json) => Loan(
        idLoan: json['id'],
        person: json['person'],
        dtLoan: json['dtDeposit'],
        description: json['description'],
        amount: json['amount'],
        observations: json['observations'],
        due: json['due'],
        totalDue: json['totalDue'],
        action: json['action'],
        status: json['status'],
      );

  Map<String, dynamic> toMap() => {
        "id": idLoan,
        "person": person,
        "dtDeposit": dtLoan,
        "description": description,
        "amount": amount,
        "observations": observations,
        "due": due,
        "totalDue": totalDue,
        "status": status,
      };
}
