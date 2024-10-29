import 'package:paymentsapp/src/data/repository/repository.dart';

class UseCase {
  final Repository repository;

  UseCase({required this.repository});

  Future<void> getDepositAsync() async {
    try {
      final result = await repository.getAllDeposit();
      if (result?.headerStatus?.code == 200) {
        print('datos: ${result}');
      } else {
        throw Exception('Error al cargar datos: ${result?.headerStatus?.code}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

/*class UseCase {
  final Repository repository;

  UseCase({required this.repository});

  Future<ResponseGeneric> getIdDeposit(String idDeposit) async {
    return await repository.getIdDeposit(idDeposit);
  }

  void getDepositAsync() async {
    try {
      final result = await repository.getAllDeposit();
      if (result?.headerStatus?.code == 200) {
        print('datos: ${result}');
      } else {
        throw Exception('Error al cargar datos');
        //model vacio
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}*/
