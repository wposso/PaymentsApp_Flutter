import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String? uid;
  String? idPerson;
  String? docType;
  String? docNumber;
  String? name;
  String? email;
  String? phone;
  double? quota;
  String? photo;
  bool? status;

  Person({
    this.uid,
    this.idPerson,
    this.docType,
    this.docNumber,
    this.name,
    this.email,
    this.phone,
    this.quota,
    this.photo,
    this.status,
  });

  factory Person.fromMap(Map<String, dynamic> json) => Person(
      uid: json['uid'],
      idPerson: json['idPerson'],
      docType: json['docType'],
      docNumber: json['docNumber'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      quota: json['quota'],
      photo: json['photo'],
      status: json['status']);

  Map<String, dynamic> toMap() => {
        "id": uid,
        "idPerson": idPerson,
        "docType": docType,
        "docNumber": docNumber,
        "name": name,
        "email": email,
        "phone": phone,
        "quota": quota,
        "photo": photo,
        "status": status
      };

  static Person fromFirestore(DocumentSnapshot doc) {
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
  }
}
