import 'package:paymentsapp/src/data/data_provider/responseApi/generic_response.dart';

abstract class Repository {
  Future<ResponseGeneric?> getAllDeposit();
  Future<ResponseGeneric> getIdDeposit(String idDeposit);
}
