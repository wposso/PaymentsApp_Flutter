// To parse this JSON data, do
//
//     final responseGeneric = responseGenericFromJson(jsonString);

import 'dart:convert';

ResponseGeneric responseGenericFromJson(String str) =>
    ResponseGeneric.fromJson(json.decode(str));

String responseGenericToJson(ResponseGeneric data) =>
    json.encode(data.toJson());

class ResponseGeneric {
  ResponseGeneric({
    this.headerStatus,
    this.messages,
    this.serverTime,
    this.data,
    this.success,
    this.codeError,
  });

  HeaderStatus? headerStatus;
  String? messages;
  DateTime? serverTime;
  dynamic data;
  bool? success;
  int? codeError;

  factory ResponseGeneric.fromJson(Map<String, dynamic> json) =>
      ResponseGeneric(
        headerStatus: HeaderStatus.fromJson(json["headerStatus"]),
        messages: json["messages"],
        serverTime: DateTime.parse(json["serverTime"]),
        data: json["data"],
        success: json["success"],
        codeError: json["codeError"],
      );

  Map<String, dynamic> toJson() => {
        "headerStatus": headerStatus!.toJson(),
        "messages": messages,
        "serverTime": serverTime!.toIso8601String(),
        "data": data!.toJson(),
        "success": success,
        "codeError": codeError,
      };
}

class HeaderStatus {
  HeaderStatus({
    this.code,
    this.description,
  });

  int? code;
  String? description;

  factory HeaderStatus.fromJson(Map<String, dynamic> json) => HeaderStatus(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
