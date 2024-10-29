import 'package:paymentsapp/src/data/data_provider/responseApi/generic_response.dart';
import 'package:paymentsapp/src/data/repository/repository.dart';
import '../data_provider/api_service/api_service.dart';

class RepositoryImpl extends Repository {
  final ApiService apiService;

  RepositoryImpl({required this.apiService});

  @override
  Future<ResponseGeneric?> getAllDeposit() async {
    try {
      final response = await apiService.getDepositAsync();
      //return responseGenericFromJson(response);
      return ResponseGeneric.fromJson(response);
    } catch (e) {
      print('Error en getAllDeposit: $e');
      return null;
    }
  }

  @override
  Future<ResponseGeneric> getIdDeposit(String idDeposit) async {
    try {
      final response = await apiService.getIdDeposit(idDeposit);
      return responseGenericFromJson(response.body);
    } catch (e) {
      print('Error en getIdDeposit: $e');
      throw Exception('Error en getIdDeposit: $e');
    }
  }
}

/*class RepositoryImpl extends Repository {
  @override
  Future<ResponseGeneric?> getAllDeposit() async {
    var response = await ApiService().getDepositAsync();
    var data = responseGenericFromJson(response as String);
    return data;
  }

  @override
  Future<ResponseGeneric> getIdDeposit(String idDeposit) async {
    var response = await ApiService().getIdDeposit(idDeposit);
    var data = responseGenericFromJson(response.body);
    return data;
  }
}*/
