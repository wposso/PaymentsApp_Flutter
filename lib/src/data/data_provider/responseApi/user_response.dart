// To parse this JSON data, do
//
//     final userResponse = userResponseFromMap(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

List<UserResponse> userResponseFromMap(String str) => List<UserResponse>.from(
    json.decode(str).map((x) => UserResponse.fromMap(x)));

String userResponseToMap(List<UserResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UserResponse {
  UserResponse(
      {this.idUser,
      this.dateOfBirth,
      this.identType,
      this.identNum,
      this.phone,
      this.isoCodePhone,
      this.photo,
      this.status,
      this.firstName,
      this.lastName,
      this.email,
      this.adress,
      this.department,
      this.gender,
      this.verified,
      this.dtRegister,
      this.idCompany,
      this.nacionality,
      this.idCountryResidence,
      this.idStableCoin,
      this.wallet,
      this.dateRegister,
      this.unicodeTransfer});

  final int? idUser;
  final DateTime? dateOfBirth;
  final String? identType;
  final String? identNum;
  final String? phone;
  final String? isoCodePhone;
  final dynamic photo;
  final int? status;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? adress;
  final String? department;
  dynamic gender;

  final bool? verified;
  final DateTime? dtRegister;
  final IdCompany? idCompany;
  final IdCountryConfig? nacionality;
  final IdCountryConfig? idCountryResidence;
  final Id? idStableCoin;
  final dynamic wallet;
  final DateTime? dateRegister;
  final String? unicodeTransfer;

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        idUser: json["idUser"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"] != null
            ? json["dateOfBirth"]
            : DateTime.now().toString()),
        identType: json["identType"] != null ? json["identType"] : '',
        identNum: json["identNum"] != null ? json["identNum"] : '',
        phone: json["phone"] != null ? json["phone"] : '',
        isoCodePhone: json["isoCodePhone"] != null ? json["isoCodePhone"] : '',
        photo: json["photo"],
        status: json["status"],
        firstName: json["firstName"] != null ? json["firstName"] : '',
        lastName: json["lastName"] != null ? json["lastName"] : '',
        email: json["email"] != null ? json["email"] : '',
        adress: json["adress"] != null ? json["adress"] : '',
        department: json["department"] != null ? json["department"] : '',
        gender: json["gender"] != null ? json["gender"] : 'M',
        unicodeTransfer:
            json["unicodeTransfer"] != null ? json["unicodeTransfer"] : '',
        verified: json["verified"] == 0 ? false : true,
        dtRegister: json["dtRegister"] != null
            ? DateTime.parse(json["dtRegister"])
            : DateTime.now(),
        wallet: json["wallet"] != null ? json["wallet"] : 0.0,
        idCompany: json["idCompany"] != null
            ? IdCompany.fromMap(json["idCompany"])
            : null,
        nacionality: json["nacionality"] != null
            ? IdCountryConfig.fromMap(json["nacionality"])
            : null,
        idCountryResidence: json["idCountryResidence"] != null
            ? IdCountryConfig.fromMap(json["idCountryResidence"])
            : null,
        idStableCoin: json["idStableCoin"] != null
            ? Id.fromMap(json["idStableCoin"])
            : null,
        dateRegister: json["dateRegister"] != null
            ? DateTime.parse(json["dateRegister"])
            : DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        "idUser": idUser,
        "dateOfBirth": dateOfBirth!.toIso8601String(),
        "identType": identType,
        "identNum": identNum,
        "phone": phone,
        "isoCodePhone": isoCodePhone,
        "photo": photo,
        "status": status,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "adress": adress,
        "department": department,
        "gender": gender,
        "unicodeTransfer": unicodeTransfer,
        "dtRegister": dtRegister!.toIso8601String(),
        "idCompany": idCompany!.toMap(),
        "nacionality": nacionality!.toMap(),
        "idCountryResidence": idCountryResidence!.toMap(),
        "idStableCoin": idStableCoin!.toMap(),
        "wallet": wallet,
        "dateRegister":
            "${dateRegister!.year.toString().padLeft(4, '0')}-${dateRegister!.month.toString().padLeft(2, '0')}-${dateRegister!.day.toString().padLeft(2, '0')}",
      };

  String birthdayString() {
    return this.dateOfBirth != null
        ? new DateFormat("dd MMMM yyyy").format(this.dateOfBirth!)
        : '-';
  }

  String registerString() {
    return this.dateRegister != null
        ? new DateFormat("dd MMMM yyyy").format(this.dtRegister!)
        : '-';
  }

  String addressCountry() {
    return '${this.adress}, ${this.idCountryResidence!.name}';
  }

  String addressCountryEditDetail() {
    return '${this.adress}';
  }
}

class IdCompany {
  IdCompany({
    this.idCompanyBinary,
    this.nameCompany,
    this.businessName,
    this.email,
    this.address,
    this.mailAddress,
    this.pobox,
    this.phone,
    this.contactInfo,
    this.representativeInfo,
    this.settings,
    this.dateRegister,
    this.dateUpdate,
    this.status,
  });

  final int? idCompanyBinary;
  final String? nameCompany;
  final String? businessName;
  final String? email;
  final String? address;
  final String? mailAddress;
  final String? pobox;
  final String? phone;
  final String? contactInfo;
  final String? representativeInfo;
  final String? settings;
  final DateTime? dateRegister;
  final DateTime? dateUpdate;
  final int? status;

  factory IdCompany.fromMap(Map<String, dynamic> json) => IdCompany(
        idCompanyBinary: json["idCompanyBinary"],
        nameCompany: json["nameCompany"],
        businessName: json["businessName"],
        email: json["email"],
        address: json["address"],
        mailAddress: json["mailAddress"],
        pobox: json["pobox"],
        phone: json["phone"],
        contactInfo: json["contactInfo"],
        representativeInfo: json["representativeInfo"],
        settings: json["settings"],
        dateRegister: DateTime.parse(json["dateRegister"]),
        dateUpdate: json["dateUpdate"] != null
            ? DateTime.parse(json["dateUpdate"])
            : null,
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "idCompanyBinary": idCompanyBinary,
        "nameCompany": nameCompany,
        "businessName": businessName,
        "email": email,
        "address": address,
        "mailAddress": mailAddress,
        "pobox": pobox,
        "phone": phone,
        "contactInfo": contactInfo,
        "representativeInfo": representativeInfo,
        "settings": settings,
        "dateRegister":
            "${dateRegister!.year.toString().padLeft(4, '0')}-${dateRegister!.month.toString().padLeft(2, '0')}-${dateRegister!.day.toString().padLeft(2, '0')}",
        "dateUpdate":
            "${dateUpdate!.year.toString().padLeft(4, '0')}-${dateUpdate!.month.toString().padLeft(2, '0')}-${dateUpdate!.day.toString().padLeft(2, '0')}",
        "status": status,
      };
}

class IdCountryConfig {
  IdCountryConfig({
    this.idCountry,
    this.idLanguage,
    this.name,
    this.code,
    this.state,
    this.isHighRisk,
    this.idFiat,
  });

  final int? idCountry;
  final dynamic idLanguage;
  final String? name;
  final String? code;
  final int? state;
  final dynamic isHighRisk;
  final Id? idFiat;

  factory IdCountryConfig.fromMap(Map<String, dynamic> json) => IdCountryConfig(
        idCountry: json["idCountry"],
        idLanguage: json["idLanguage"],
        name: json["name"],
        code: json["code"],
        state: json["state"],
        isHighRisk: json["isHighRisk"],
      );

  Map<String, dynamic> toMap() => {
        "idCountry": idCountry,
        "idLanguage": idLanguage,
        "name": name,
        "code": code,
        "state": state,
        "isHighRisk": isHighRisk,
        "idFiat": idFiat!.toMap(),
      };
}

class Id {
  Id({
    this.idMoney,
    this.name,
    this.symbol,
    this.status,
    this.currencyCode,
    this.urlLogo,
    this.subName,
    this.codeBinance,
    this.codeExchange,
    this.isStableCoin,
    this.idParFiat,
    this.isDefaultStableCoin,
    this.idTypeCoin,
  });

  final int? idMoney;
  final String? name;
  final String? symbol;
  final int? status;
  final String? currencyCode;
  final String? urlLogo;
  final String? subName;
  final String? codeBinance;
  final dynamic codeExchange;
  final int? isStableCoin;
  final int? idParFiat;
  final int? isDefaultStableCoin;
  final IdTypeCoin? idTypeCoin;

  factory Id.fromMap(Map<String, dynamic> json) => Id(
        idMoney: json["idMoney"],
        name: json["name"],
        symbol: json["symbol"],
        status: json["status"],
        currencyCode: json["currencyCode"],
        urlLogo: json["urlLogo"],
        subName: json["subName"] == null ? null : json["subName"],
        codeBinance: json["codeBinance"] == null ? null : json["codeBinance"],
        codeExchange: json["codeExchange"],
        isStableCoin: json["isStableCoin"],
        idParFiat: json["idParFiat"] == null ? null : json["idParFiat"],
        isDefaultStableCoin: json["isDefaultStableCoin"],
        idTypeCoin: IdTypeCoin.fromMap(json["idTypeCoin"]),
      );

  Map<String, dynamic> toMap() => {
        "idMoney": idMoney,
        "name": name,
        "symbol": symbol,
        "status": status,
        "currencyCode": currencyCode,
        "urlLogo": urlLogo,
        "subName": subName == null ? null : subName,
        "codeBinance": codeBinance == null ? null : codeBinance,
        "codeExchange": codeExchange,
        "isStableCoin": isStableCoin,
        "idParFiat": idParFiat == null ? null : idParFiat,
        "isDefaultStableCoin": isDefaultStableCoin,
        "idTypeCoin": idTypeCoin!.toMap(),
      };
}

class IdTypeCoin {
  IdTypeCoin({
    this.idCfgCoinType,
    this.label,
  });

  final int? idCfgCoinType;
  final String? label;

  factory IdTypeCoin.fromMap(Map<String, dynamic> json) => IdTypeCoin(
        idCfgCoinType: json["idCfgCoinType"],
        label: json["label"],
      );

  Map<String, dynamic> toMap() => {
        "idCfgCoinType": idCfgCoinType,
        "label": label,
      };
}
