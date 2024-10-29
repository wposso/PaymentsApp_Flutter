class Liability {
  final int
      idLibiality; //manejar deudas general porque se va a necesitar cuotas y cuotas finales
  final String idDebit; //convertir a modelo porque necesito el nombre
  final String dtLiability;
  final String description;
  final String amount;
  final String observations;
  final int status;

  Liability({
    required this.idLibiality,
    required this.idDebit,
    required this.dtLiability,
    required this.description,
    required this.amount,
    required this.observations,
    required this.status,
  });

  factory Liability.fromMap(Map<String, dynamic> json) => Liability(
      idLibiality: json['idLibiality'],
      idDebit: json['idDebit'],
      dtLiability: json['dtDeposit'],
      description: json['description'],
      amount: json['amount'],
      observations: json['observations'],
      status: json['status']);

  Map<String, dynamic> toMap() => {
        "idLibiality": idLibiality,
        "idDebit": idDebit,
        "dtDeposit": dtLiability,
        "description": description,
        "amount": amount,
        "observations": observations,
        "status": status
      };
}
