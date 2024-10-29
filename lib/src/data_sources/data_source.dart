import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:paymentsapp/settings.dart';
import 'package:paymentsapp/src/data/data_provider/api_service/endpoints.dart';
import 'package:paymentsapp/src/data/models/Deposit.dart';
import 'package:http/http.dart' as http;

abstract class DataSource {
  var cliente = http.Client();
  Logger _logger = Logger();

  Future<Map<String, String>> getHeaders(bool hasAuthorization) async {
    var headers = <String, String>{};
    if (hasAuthorization) {
      final token = '', //await LocalRepositoryImpl().getToken();
          headers = {
            'api-key': Settings.apiKey,
            'Authorization': 'Bearer ${token!}',
            'Content-Type': 'application/json'
          };
    } else {
      headers = {
        'api-key': Settings.apiKey,
        'Content-Type': 'application/json'
      };
    }
    _logger.i(headers);
    return headers;
  }

  // Headers MPOS
  Future<Map<String, String>> setHeaders() async {
    var headers = <String, String>{};

    headers = {
      'Authorization': Settings.apiKey,
      'Content-Type': 'application/json'
    };

    return headers;
  }

  Future<http.Response> getAllDeposits() async {
    var response = await cliente.get(
        Uri.parse(Settings.UrlApi + EndPoint.getAllDeposit),
        headers: await getHeaders(true));
    return response;
  }
}
