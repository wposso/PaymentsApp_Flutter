class Deposit {
  int? id;
  String? idPerson;
  String? dtDeposit;
  String? description;
  String? amount;
  String? observations;
  int? status;

  Deposit({
    this.id,
    this.dtDeposit,
    this.description,
    this.amount,
    this.observations,
    this.status,
  });

  factory Deposit.fromMap(Map<String, dynamic> json) => Deposit(
      id: json['id'],
      dtDeposit: json['dtDeposit'],
      description: json['description'],
      amount: json['amount'],
      observations: json['observations'],
      status: json['status']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "dtDeposit": dtDeposit,
        "description": description,
        "amount": amount,
        "observations": observations,
        "status": status
      };

  /*static Person fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Person(
      uid: doc.id,
      name: data['name'],
      email: data['email'],
      idPerson: '',
      docType: data['docType'],
      docNumber: data['docNumber'],
      phone: data['phone'],
      quota: data['quota'],
      photo: data['photo'],
      status: data['status'],
    );
  }*/
}
