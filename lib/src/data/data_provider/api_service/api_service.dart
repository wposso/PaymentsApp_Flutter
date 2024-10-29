import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:paymentsapp/settings.dart';
import 'package:paymentsapp/src/data/data_provider/api_service/endpoints.dart';

class ApiService {
  var cliente = http.Client();
  Logger _logger = Logger();

  var urlLogin = Uri.parse(Settings.UrlApi + EndPoint.login);

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

  //Login
  Future<http.Response> login(Settings login) async {
    var body =
        //jsonEncode(<String, String>{"email": login.email, "pwd": login.pwd});
        jsonEncode(
            <String, String>{"email": "felmont@hotmail.com", "pwd": "123456"});
    var response = await cliente.post(urlLogin,
        headers: await getHeaders(false), body: body);

    return response;
  }

  Future<Map<String, dynamic>> getDepositAsync() async {
    try {
      final response = await http.get(
          Uri.parse(Settings.UrlApi + EndPoint.getAllDeposit),
          headers: await getHeaders(true));
      return apiResponse(response);
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }
  }

  Map<String, dynamic> apiResponse(http.Response response) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

  Future<http.Response> getIdDeposit(String idDeposit) async {
    var response = await cliente.get(
        Uri.parse(Settings.UrlApi + EndPoint.getDeposit + '/$idDeposit'),
        headers: await getHeaders(true));
    return response;
  }

  /*Future<http.Response> getAllDeposits() async {
    var response = await cliente.get(
        Uri.parse(Settings.UrlApi + EndPoint.getAllDeposit),
        headers: await getHeaders(true));
    return response;
  }*/

  /*Future<Map<String, dynamic>> getDepositAsync(
      String data, String authorization) async {
    try {
      final response = await http.get(
          Uri.parse(Settings.UrlApi + EndPoint.getAllDeposit),
          headers: await getHeaders(true));
      return apiResponse(response);
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }
  }*/

  /*
  //Logout
  /*Future<http.Response> logout() async {
    final idUser = await LocalRepositoryImpl().getIdUser();
    var response = await cliente.get(
        Uri.parse(Settings.UrlApi + EndPoint.logout + idUser!),
        headers: await getHeaders(true));

    return response;
  }*/

  //Merchants

  Future<http.Response> getMerchants(String queryFilter) async {
    var response = await cliente.get(
        Uri.parse(Settings.UrlApi + EndPoint.merchants + queryFilter),
        headers: await getHeaders(true));
    return response;
  }

  Future<http.Response> getMerchantsDetail(int idMerchant) async {
    var response = await cliente.get(
        Uri.parse(Settings.UrlApi +
            EndPoint.merchantsDetail +
            '/$idMerchant'),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getMerchantsContact(int idMerchant) async {
    var response = await cliente.get(
        Uri.parse(Settings.UrlApi +
            EndPoint.merchantContact +
            '/$idMerchant'),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getMerchantsBalance(int idMerchant) async {
    var response = await cliente.get(
        Uri.parse(
            Settings.UrlApi + EndPoint.merchantBalance + '$idMerchant'),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getMerchantsCrypto(int idMerchant) async {
    var response = await cliente.get(
        Uri.parse(
            Settings.UrlApi + EndPoint.merchantCrypto + '$idMerchant'),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getMerchantsSettlement(int idMerchant) async {
    var response = await cliente.get(
        Uri.parse(Settings.UrlApi +
            EndPoint.merchantSettlement +
            '$idMerchant'),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> saveMerchantData(int idMerchant, String body) async {
    var response = await cliente.put(
        Uri.parse(Settings.UrlApi +
            EndPoint.merchantsDetail +
            '/$idMerchant'),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> saveMerchantImage(
      int idMerchant, Map<String, dynamic> merchat) async {
    var response = await cliente.put(
        Uri.parse(Settings.UrlApi +
            EndPoint.merchantsDetail +
            '/$idMerchant'),
        headers: await getHeaders(true),
        body: jsonEncode(merchat));

    return response;
  }

  Future<http.Response> saveMerchantContact(int idMerchant, String body) async {
    var response = await cliente.post(
        Uri.parse(Settings.UrlApi + EndPoint.merchantContactSave),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> saveMerchantNewData(String body) async {
    var response = await cliente.post(
      Uri.parse(Settings.UrlApi + EndPoint.merchantsDetail),
      headers: await getHeaders(true),
      body: body,
    );

    return response;
  }

  Future<http.Response> saveMerchantComment(
      int idCommerce, String comment) async {
    var response = await cliente.post(
      Uri.parse(Settings.UrlApi + EndPoint.merchantPostComments),
      headers: await getHeaders(true),
      body: jsonEncode({"idCommerce": idCommerce, "comment": comment}),
    );

    return response;
  }

  Future<http.Response> getMerchantComments(int idMerchant) async {
    var response = await cliente.get(
        Uri.parse(Settings.UrlApi +
            EndPoint.merchantComments +
            '$idMerchant'),
        headers: await getHeaders(true));

    return response;
  }

  // Companies

  Future<http.Response> getMoneyNoCrypto() async {
    var headers = await getHeaders(true);
    var url = Uri.parse(Settings.UrlApi + EndPoint.moneyNoCrypto);
    var response = await cliente.get(url, headers: headers);

    return response;
  }

  Future<http.Response> getCompanies() async {
    var headers = await getHeaders(true);
    var url = Uri.parse(Settings.UrlApi + EndPoint.companies);
    var response = await cliente.get(url, headers: headers);
    //_logger.d();
    //log(response.body);
    return response;
  }

  Future<http.Response> getCompaniesWithFilters(String queryFilters) async {
    var headers = await getHeaders(true);
    var url =
        Uri.parse(AppConfiguration.UrlApi + EndPoint.companies + queryFilters);

    var response = await cliente.get(url, headers: headers);

    return response;
  }

  Future<http.Response> getCompanyDetail(int idCompany) async {
    var response = await cliente.get(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.companies + '/$idCompany'),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getCompanyCountries(int idCompany) async {
    var response = await cliente.get(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.companiesCountries +
            '$idCompany&status=true'),
        headers: await getHeaders(true));
    return response;
  }

  Future<http.Response> getCompanyBankAccounts(int idCompany) async {
    var response = await cliente.get(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.companiesBankAccounts +
            '$idCompany&status=true'),
        headers: await getHeaders(true));
    return response;
  }

  Future<http.Response> getCompanyLimits(int idCompany) async {
    var response = await cliente.get(
        Uri.parse(
            AppConfiguration.UrlApi + EndPoint.companiesLimits + '$idCompany'),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getCompanyCosts(int idCompany) async {
    var response = await cliente.get(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.companiesCosts +
            '$idCompany?status=true'),
        headers: await getHeaders(true));
    return response;
  }

  Future<http.Response> saveCompany(String body) async {
    var response = await cliente.post(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.companies),
        headers: await getHeaders(true),
        body: body);
    return response;
  }

  Future<http.Response> editCompany(String body, int idCompany) async {
    var response = await cliente.put(
        Uri.parse(
            AppConfiguration.UrlApi + EndPoint.companies + '/${idCompany}'),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> saveLimitCompany(String body) async {
    var response = await cliente.post(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.companyLimit),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> updateLimitCompany(
      String body, int idCompanyLimit) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.companyLimit +
            '/${idCompanyLimit}'),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> deleteCompanyBankAccount(
      String body, int idCompany) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.companyBankAccount +
            '/${idCompany}'),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> deleteCompanyCountry(
      String body, int idCompanyCountry) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.companyCountry +
            '/${idCompanyCountry}'),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> saveCostCompany(String body) async {
    var response = await cliente.post(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.companyCost),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> updateCostCompany(
      String body, int idCompanyCost) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.companyCost +
            '/${idCompanyCost}'),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> saveCountryCompany(String body) async {
    var response = await cliente.post(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.companyCountry),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> updateCountryCompany(
      String body, int idCompanyCountry) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.companyCountry +
            '/${idCompanyCountry}'),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> saveBankAccountCompany(String body) async {
    var response = await cliente.post(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.companyBankAccount),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  Future<http.Response> updateBankAccountCompany(
      String body, int idCompanyBankAccount) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.companyBankAccount +
            '/${idCompanyBankAccount}'),
        headers: await getHeaders(true),
        body: body);

    return response;
  }

  //Users

  Future<http.Response> getUsers(String queryFilter) async {
    var response = await cliente.get(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.users + queryFilter),
        headers: await getHeaders(true));

    //log(response.body);
    return response;
  }

  Future<http.Response> getUserDetail(int idUser) async {
    var response = await cliente.get(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.userDetail + '/$idUser'),
        headers: await getHeaders(true));
    //  log(response.body);
    return response;
  }

  Future<http.Response> putUser(int idUser, Map<String, dynamic> user) async {
    var body = jsonEncode(user);
    var response = await cliente.put(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.userDetail + '/$idUser',
        ),
        body: body,
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getUserComment(int idUser) async {
    var response = await cliente.get(
      Uri.parse(AppConfiguration.UrlApi + EndPoint.userGetComments + '$idUser'),
      headers: await getHeaders(true),
    );

    return response;
  }

  Future<http.Response> saveUserComment(int idUser, String comment) async {
    var response = await cliente.post(
      Uri.parse(AppConfiguration.UrlApi + EndPoint.userPostComments),
      headers: await getHeaders(true),
      body: jsonEncode({"idUser": idUser, "comment": comment}),
    );

    return response;
  }

  Future<http.Response> putUserDisabledEnabled(int idUser, String user) async {
    var response = await cliente.put(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.userDetail + '/$idUser',
        ),
        body: user,
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> postUser(String body) async {
    var response = await cliente.post(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.userDetail),
        body: body,
        headers: await getHeaders(true));
    //log(response.body);
    return response;
  }

  Future<http.Response> changeUserPassword(String body) async {
    var response = await cliente.post(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.userChangePassword),
        body: body,
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getUserLimits(int idUser) async {
    var response = await cliente.get(
      Uri.parse(AppConfiguration.UrlApi + EndPoint.userLimits + '$idUser'),
      headers: await getHeaders(true),
    );

    return response;
  }

  Future<http.Response> getUserCosts(int idUser) async {
    var response = await cliente.get(
      Uri.parse(AppConfiguration.UrlApi + EndPoint.userCosts + '$idUser'),
      headers: await getHeaders(true),
    );

    return response;
  }

  Future<http.Response> getUserDailyLimit(int idUser, bool hasVerified) async {
    var response = await cliente.get(
      Uri.parse(AppConfiguration.UrlApi +
          EndPoint.dailyLimits +
          '$idUser' +
          '&hasVerification=$hasVerified'),
      headers: await getHeaders(true),
    );
    return response;
  }

  /** User Files */

  Future<UserFileData> getUserFiles(int idUser) async {
    http.Response httpResponse = await cliente.get(
      Uri.parse(AppConfiguration.UrlApi + EndPoint.getUserFiles + '$idUser'),
      headers: await getHeaders(true),
    );

    if (httpResponse.statusCode != 200) {
      _logger.e('http response error; statusCode: ${httpResponse.statusCode}');
      //TODO: Thow exception
    }

    final bodyJson = jsonDecode(httpResponse.body) as Map<String, dynamic>;

    if (bodyJson["codeError"] != 0) {
      _logger.e('Internal error code: ${bodyJson["codeError"]}');
      //Some internal error
    }
    log(httpResponse.body);

    final userFilesResponse = userFilesResponseFromMap(httpResponse.body);
    return userFilesResponse.data;
  }

  Future<UserFileData> getUserFilesFiltered({
    required int idUser,
    required int? pageQuery,
    required int? idCategory,
    required String? query,
    int? takeQuery = 10,
  }) async {
    if (idCategory == 0) idCategory = null;

    var queryParameters = {
      'idUser': idUser.toString(),
      'pageQuery': pageQuery == null ? '' : pageQuery.toString(),
      'takeQuery': takeQuery == null ? '' : takeQuery.toString(),
      'idCategory': idCategory == null ? '' : idCategory.toString(),
      'nameFile': query == null ? '' : query
    };

    // if (idCategory != 0) {
    //   queryParameters = {
    //     'idUser': idUser.toString(),
    //     'pageQuery': pageQuery.toString(),
    //     'takeQuery': takeQuery.toString(),
    //     'idCategory': idCategory.toString(),
    //     'nameFile': query
    //   };
    // } else {
    //   queryParameters = {
    //     'idUser': idUser.toString(),
    //     'pageQuery': pageQuery.toString(),
    //     'takeQuery': takeQuery.toString(),
    //     'nameFile': query
    //   };
    // }

    var uri = Uri.https(AppConfiguration.apiAuthority,
        EndPoint.getUserFilesFilteredByName, queryParameters);
    _logger.d(uri);
    http.Response httpResponse = await cliente.get(
      uri,
      headers: await getHeaders(true),
    );
    //_logger.i(uri);

    //_logger.i(httpResponse.body);
    //log(httpResponse.body);

    if (httpResponse.statusCode != 200) {
      _logger.e('http response error; statusCode: ${httpResponse.statusCode}');
      //TODO: Thow exception
    }

    final bodyJson = jsonDecode(httpResponse.body) as Map<String, dynamic>;

    if (bodyJson["codeError"] != 0) {
      _logger.e('Internal error code: ${bodyJson["codeError"]}');
      //Some internal error
    }

    final userFilesResponse = userFilesResponseFromMap(httpResponse.body);
    //log(httpResponse.body);
    return userFilesResponse.data;
  }

  Future<List<FileCategory>> getUserFileCategories(int idUser) async {
    var httpResponse = await cliente.get(
      Uri.parse(
          AppConfiguration.UrlApi + EndPoint.getUserFileCategories + '$idUser'),
      headers: await getHeaders(true),
    );

    if (httpResponse.statusCode != 200) {
      _logger.e('http response error; statusCode: ${httpResponse.statusCode}');
      //TODO: Thow exception
    }

    final bodyJson = jsonDecode(httpResponse.body) as Map<String, dynamic>;

    if (bodyJson["codeError"] != 0) {
      _logger.e('Internal error code: ${bodyJson["codeError"]}');
      //Some internal error
    }

    final fileCategoriesResponse =
        fileCategoriesResponseFromMap(httpResponse.body);

    //log(response.body);
    return fileCategoriesResponse.categoryList;
  }

  Future<http.Response> createNewUserCategory(FileCategory newCategory) async {
    //_//Logger.d(jsonEncode(newCategory.toMap()));
    var response = await cliente.post(
      Uri.parse(AppConfiguration.UrlApi + EndPoint.createNewUserCategory),
      headers: await getHeaders(true),
      body: jsonEncode(newCategory.toMap()),
    );
    //log(response.body);
    //log(jsonEncode(newCategory.toMap()));
    return response;
  }

  Future<http.Response> createNewFile(FileItem newFile) async {
    FileItem fileItem = FileItem(
      idUser: newFile.idUser,
      idUsrCategory: newFile.idUsrCategory,
      label: newFile.label,
      descr: '',
      isJsonDocument: 0,
      idDocumentType: newFile.idDocumentType,
      doc: newFile.doc,
    );
    //log(jsonEncode(fileItem.toMap()));
    var response = await cliente.post(
      Uri.parse(AppConfiguration.UrlApi + EndPoint.createNewFile),
      headers: await getHeaders(true),
      body: jsonEncode(fileItem.toMap()),
    );

    return response;
  }

  Future<http.Response> putLimitUsr(double limitValue, String idLimit) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.updateLimit + idLimit),
        body: jsonEncode({'limitValue': limitValue.toString()}),
        headers: await getHeaders(true));

    return response;
  }

  // costs

  Future<http.Response> putCostUsr(double limitValue, String idCost) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.updateCosts + idCost),
        body: jsonEncode({'costValue': limitValue.toString()}),
        headers: await getHeaders(true));

    return response;
  }

  //Cryptos

  Future<http.Response> getUserCryptos(int idUser) async {
    var response = await cliente.get(
        Uri.parse(
            AppConfiguration.UrlApi + EndPoint.cryptoUserById + '$idUser'),
        headers: await getHeaders(true));

    return response;
  }

  //movements
  Future<http.Response> getMovements(int page, int elements, int idUser) async {
    var headers = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi +
        '/com-account-movements/get-by-user/$idUser?take=$elements&page=$page');

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getMerchantMovements(
      int page, int elements, int idCom) async {
    var headers = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi +
        '/com-account-movements/get-by-commerce/$idCom?take=$elements&page=$page');

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  //Countries

  Future<http.Response> getCountries() async {
    var headers = {"api-key": "OMpQBinary6F23Swap21G"};

    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.countries);

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getCountryByCode(String codeCountry) async {
    var headers = {"api-key": "OMpQBinary6F23Swap21G"};

    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.countryByCode + codeCountry);

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  // Banks

  Future<http.Response> getBanks() async {
    var headers = await getHeaders(true);

    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.banks);

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getBankDetail(int idBank) async {
    var headers = await getHeaders(true);

    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.banks + '/' + idBank.toString());

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getBanksFiltered(String queryFilter) async {
    var headers = await getHeaders(true);

    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.banks + queryFilter);

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> putBank(Map<String, dynamic> body, int idBank) async {
    var headers = await getHeaders(true);

    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.banks + '/$idBank');

    var response =
        await cliente.put(body: jsonEncode(body), url, headers: headers);
    return response;
  }

  Future<http.Response> postBank(
    String body,
  ) async {
    var headers = await getHeaders(true);

    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.banks);

    var response = await cliente.post(body: body, url, headers: headers);
    return response;
  }

  Future<http.Response> getLimits() async {
    var headers = await getHeaders(true);

    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.limits);

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getCosts() async {
    var headers = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.costs);
    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getStableCoins() async {
    var headers = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.stableCoins);
    var response = await cliente.get(url, headers: headers);
    //log(response.body);
    return response;
  }

  Future<http.Response> getCreditCardsUsers(int idUser) async {
    var headers = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + '/com-cards/$idUser');

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getTotalBalanceUser(int idUser) async {
    var headers = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi +
        EndPoint.totalBalanceUser +
        idUser.toString());

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getComTypes() async {
    var headers = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.merchantTypes);
    var response = await cliente.get(url, headers: headers);

    return response;
  }

  Future<http.Response> getBanksAll() async {
    var headers = await getHeaders(true);

    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.banks);

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  Future<http.Response> getFilterBanks(String query) async {
    var headers = await getHeaders(true);

    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.banks + '?bankName=$query');

    var response = await cliente.get(url, headers: headers);
    return response;
  }

  //---------------- MPOS -------------------

  Future<http.Response> getMposTx(String body) async {
    var headers = await setMposHeaders();
    var url = Uri.parse(AppConfiguration.MposUrlApi +
        AppConfiguration.MposCommerceToken +
        '/TxTransactions');

    var response = await cliente.post(url, headers: headers, body: body);
    return response;
  }

  Future<http.Response> getMposTxDynamic(
      String body, String methodType, String tokenMerchant) async {
    var headers = await setMposHeaders();
    var url =
        Uri.parse(AppConfiguration.MposUrlApi + tokenMerchant + '/$methodType');
    // '/TxTransactions');

    var response = await cliente.post(url, headers: headers, body: body);
    return response;
  }

  Future<http.Response> getOfficerAccount(int idAtomoCompany) async {
    var headers = await getHeaders(true);
    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.officerAccount + '$idAtomoCompany');
    var response = await cliente.get(url, headers: headers);

    return response;
  }

  //crypto bridge

  Future<http.Response> postCreateCryptoBridge(
      Map<String, dynamic> body) async {
    var response = await cliente.post(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.cryptoBridge),
        body: jsonEncode(body),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getCryptosBridges(int idMerchant) async {
    var response = await cliente.get(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.getCryptosBridges +
            idMerchant.toString()),
        // body: jsonEncode(body),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getCryptoBridge(String idMerchant) async {
    var response = await cliente.get(
        Uri.parse(
            AppConfiguration.UrlApi + EndPoint.getCryptoBridge + idMerchant),
        // body: jsonEncode(body),
        headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> putCryptoBridge(
      Map<String, dynamic> body, String idCryptoBridge) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.putCryptoBridge +
            idCryptoBridge),
        body: jsonEncode(body),
        headers: await getHeaders(true));

    return response;
  }

  /**--Country Catalog--
   * The response will bring all valid countries.
   * [countryState] defines Country Status
   * Default 1 brings all valid countries.
   * call method with 0 to bring only disabled countries.
   */
  Future<CountryCatalog> getCountryCatalog() async {
    //Logger().d('Api Service Get Countries');
    var httpResponse = await cliente.get(
        Uri.parse(AppConfiguration.UrlApi + EndPoint.getCountryCatalog),
        headers: await getHeaders(true));

    if (httpResponse.statusCode != 200) {
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }

    final bodyJson = jsonDecode(httpResponse.body) as Map<String, dynamic>;
    if (!bodyJson.containsKey('data')) {
      //Throws no data exception
    }

    if (bodyJson["codeError"] != 0) {
      //Some internal error
    }

    //Logger().d(httpresponse.body);
    //log(httpresponse.body);
    CountryCatalog countryCatalog = countryCatalogFromMap(httpResponse.body);
    return countryCatalog;
  }

  Future<CountryCatalogHighRisk> getHighRiskCountryCatalog() async {
    //Logger().d('Api Service Get High Risk Countries');
    var httpResponse = await cliente.get(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.getHighRiskCountryCatalog,
        ),
        headers: await getHeaders(true));

    if (httpResponse.statusCode != 200) {
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }

    final bodyJson = jsonDecode(httpResponse.body) as Map<String, dynamic>;
    if (!bodyJson.containsKey('data')) {
      //Throws no data exception
    }

    if (bodyJson["codeError"] != 0) {
      //Some internal error
    }

    //Logger().d(httpresponse.body);
    CountryCatalogHighRisk countryCatalogHighRisk =
        countryCatalogHighRiskFromMap(httpResponse.body);
    return countryCatalogHighRisk;
  }

  Future<CountryCatalogBlackListed> getBlackListedCountryCatalog() async {
    //Logger().d('Api Service Get High Risk Countries');
    var httpresponse = await cliente.get(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.getBlackListedCountryCatalog,
        ),
        headers: await getHeaders(true));

    if (httpresponse.statusCode != 200) {
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }

    final bodyJson = jsonDecode(httpresponse.body) as Map<String, dynamic>;
    if (!bodyJson.containsKey('data')) {
      //Throws no data exception
    }

    if (bodyJson["codeError"] != 0) {
      //Some internal error
    }

    //Logger().d(httpresponse.body);
    CountryCatalogBlackListed countryCatalogBlackListed =
        countryCatalogBlackListedFromMap(httpresponse.body);
    return countryCatalogBlackListed;
  }

  //Create new Country
  Future<http.Response> createNewCountry(NewCountryItem newCountryItem) async {
    //Logger().d('Api Service POST New Country');
    var httpresponse = await cliente.post(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.createNewCountry,
        ),
        headers: await getHeaders(true),
        body: newCountryItemToMap(newCountryItem));

    if (httpresponse.statusCode != 201) {
      //_logger.e('Response status code: ${httpresponse.statusCode}');
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }
    final bodyJson = jsonDecode(httpresponse.body) as Map<String, dynamic>;
    if (bodyJson["codeError"] != 0) {
      //Some internal error
      //_logger.e('Server Internal Error code: ${bodyJson["codeError"]}');
    }
    //Logger().d(httpresponse.body);
    return httpresponse;
  }

  Future<http.Response> modifyCountry(
      ModifyCountryItem modifyCountryItem, int countryId) async {
    //Logger().d('Api Service modify Country');
    var httpresponse = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.modifyCountry +
            countryId.toString()),
        headers: await getHeaders(true),
        body: modifiedCountryItemToMap(modifyCountryItem));

    if (httpresponse.statusCode != 200) {
      //_Logger.e('Response status code: ${httpresponse.statusCode}');
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }
    final bodyJson = jsonDecode(httpresponse.body) as Map<String, dynamic>;
    if (bodyJson["codeError"] != 0) {
      //Some internal error
      //_logger.e('Server Internal Error code: ${bodyJson["codeError"]}');
    }
    //Logger().d(httpresponse.body);
    return httpresponse;
  }

  Future<http.Response> addCountryToHighRisk(
      AddToHighRiskItem addToHighRiskItem) async {
    //Logger().d('Api Service POST New Country');
    var httpresponse = await cliente.post(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.addCountryToHighRisk,
        ),
        headers: await getHeaders(true),
        body: addToHighRiskItemToMap(addToHighRiskItem));

    if (httpresponse.statusCode != 201) {
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }

    final bodyJson = jsonDecode(httpresponse.body) as Map<String, dynamic>;
    if (bodyJson["codeError"] != 0) {
      //Some internal error
    }

    //Logger().d(httpresponse.body);
    return httpresponse;
  }

  Future<http.Response> addCountryToBlackListed(
      AddToBlackListedItem addToBlackListedItem) async {
    //Logger().d('Api Service POST New Country');
    var httpresponse = await cliente.post(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.addCountryToBlackListed,
        ),
        headers: await getHeaders(true),
        body: addToBlackListedItemToMap(addToBlackListedItem));

    if (httpresponse.statusCode != 201) {
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }

    final bodyJson = jsonDecode(httpresponse.body) as Map<String, dynamic>;
    if (bodyJson["codeError"] != 0) {
      //Some internal error
    }

    //Logger().d(httpresponse.body);
    return httpresponse;
  }

  Future<http.Response> deleteCountryFromHighRisk(int highRiskCountryId) async {
    var response = await cliente.delete(
      Uri.parse(AppConfiguration.UrlApi +
          EndPoint.deleteHighRisk +
          '/${highRiskCountryId}'),
      headers: await getHeaders(true),
    );
    //_logger.i(response.body);
    return response;
  }

  Future<http.Response> deleteCountryFromBlackListed(
      int blackListedCountryId) async {
    var response = await cliente.delete(
      Uri.parse(AppConfiguration.UrlApi +
          EndPoint.deleteBlackListed +
          '/${blackListedCountryId}'),
      headers: await getHeaders(true),
    );
    //_logger.d(response.body);
    return response;
  }

  Future<EnabledCountryList> getEnabledCountries() async {
    //Logger().d('Api Service Get Enabled Countries');
    var httpresponse = await cliente.get(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.getEnabledCountries,
        ),
        headers: await getHeaders(true));

    if (httpresponse.statusCode != 200) {
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }

    final bodyJson = jsonDecode(httpresponse.body) as Map<String, dynamic>;
    if (!bodyJson.containsKey('data')) {
      //Throws no data exception
    }

    if (bodyJson["codeError"] != 0) {
      //Some internal error
    }

    //Logger().d(httpresponse.body);
    //log(httpresponse.body);

    EnabledCountryList availableCountryList =
        enabledCountryListFromMap(httpresponse.body);
    return availableCountryList;
  }

  Future<AvailableFiatResponse> getAvailableFiat() async {
    //Logger().d('Api Service Get Available Fiat');
    var httpresponse = await cliente.get(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.getAvailableFiat,
        ),
        headers: await getHeaders(true));

    if (httpresponse.statusCode != 200) {
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }

    final bodyJson = jsonDecode(httpresponse.body) as Map<String, dynamic>;
    if (!bodyJson.containsKey('data')) {
      //Throws no data exception
    }

    if (bodyJson["codeError"] != 0) {
      //Some internal error
    }

    //Logger().d(httpresponse.body);

    AvailableFiatResponse availableFiatResponse =
        availableFiatFromMap(httpresponse.body);
    return availableFiatResponse;
  }

  Future<http.Response> getAdministrators() async {
    var headers = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.internalUser);
    var response = await cliente.get(url, headers: headers);

    return response;
  }

  Future<http.Response> getAdministratorsDetail(int idUserAdmin) async {
    var headers = await getHeaders(true);
    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.internalUser + '/$idUserAdmin');
    var response = await cliente.get(url, headers: headers);

    return response;
  }

  Future<http.Response> postAdministrator(
    Map<String, dynamic> body,
  ) async {
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.internalUser);
    var response = await cliente.post(url,
        body: jsonEncode(body), headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> putAdministrator(
      Map<String, dynamic> body, int idUserAdministrator) async {
    var url = Uri.parse(AppConfiguration.UrlApi +
        EndPoint.internalUser +
        '/$idUserAdministrator');
    var response = await cliente.put(url,
        body: jsonEncode(body), headers: await getHeaders(true));

    return response;
  }

  Future<http.Response> getAdministratorsFiltered(String queryFilter) async {
    var headers = await getHeaders(true);
    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.internalUser + queryFilter);
    var response = await cliente.get(url, headers: headers);

    return response;
  }

  Future<http.Response> postChangeAdministratorPassword(
      int idUserAdministrator, String password) async {
    var headers = await getHeaders(true);
    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.internalUserChangePassword);
    var response = await cliente.post(url,
        headers: headers,
        body: jsonEncode({"idUser": idUserAdministrator, "pwd": password}));

    return response;
  }

  Future<dynamic> getSwift(String swift) async {
    var header = await getHeaders(true);
    // var url = host.toString() + '/cfg-banks/get-swift/$swift';
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.getSwift + swift);
    var response = await cliente.get(url, headers: header);
    return response;
  }

  //costs

  Future<dynamic> getCostsSettings() async {
    var header = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.costsWithOutFilter);
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<http.Response> putCost(
      Map<String, dynamic> body, String idCost) async {
    var response = await cliente.put(
        Uri.parse(
            AppConfiguration.UrlApi + EndPoint.costsWithOutFilter + '/$idCost'),
        body: jsonEncode(body),
        headers: await getHeaders(true));

    return response;
  }

  Future<dynamic> getLimitsSettings() async {
    var header = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.limitsWithOutFilter);
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<http.Response> putLimits(
      Map<String, dynamic> body, String idLimit) async {
    var response = await cliente.put(
        Uri.parse(AppConfiguration.UrlApi +
            EndPoint.limitsWithOutFilter +
            '/$idLimit'),
        body: jsonEncode(body),
        headers: await getHeaders(true));

    return response;
  }

  //money

  Future<dynamic> getCryptosSettings(bool status) async {
    var header = await getHeaders(true);
    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.cryptoSettings + '?status=$status');
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<dynamic> posCryptosSettings(Map<String, dynamic> body) async {
    var header = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.cryptoSettingsPos);
    var data = jsonEncode(body);
    var response = await cliente.post(url, headers: header, body: data);
    return response;
  }

  Future<dynamic> putCryptosSettings(
      Map<String, dynamic> body, int idCrypto) async {
    var header = await getHeaders(true);
    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.cryptoSettingsPos + '/$idCrypto');
    var data = jsonEncode(body);
    var response = await cliente.put(url, headers: header, body: data);
    return response;
  }

  // coint ype

  Future<dynamic> getCoinType() async {
    var header = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.coinType);
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<dynamic> getFiat() async {
    var header = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.fiat);
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<dynamic> getFundsRequest(String queryParams) async {
    var header = await getHeaders(true);
    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.fundsRequest + queryParams);
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<dynamic> getFundsRequestDetail(int idFun) async {
    var header = await getHeaders(true);
    var url =
        Uri.parse(AppConfiguration.UrlApi + EndPoint.fundsRequest + '/$idFun');
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<dynamic> putRequest(int idFun, Map<String, dynamic> body) async {
    var header = await getHeaders(true);
    var url =
        Uri.parse(AppConfiguration.UrlApi + EndPoint.fundsRequest + '/$idFun');
    var response =
        await cliente.put(url, headers: header, body: jsonEncode(body));
    return response;
  }

  Future<dynamic> getDepositBankFiltered(String queryParams) async {
    var header = await getHeaders(true);
    var url = Uri.parse(
        AppConfiguration.UrlApi + EndPoint.usrDepositBank + queryParams);
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<dynamic> postDepositBank(Map<String, dynamic> body) async {
    var header = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.usrDepositBank);
    var response =
        await cliente.post(url, headers: header, body: jsonEncode(body));
    return response;
  }

  Future<dynamic> getUnicodeUser(String unicode) async {
    var header = await getHeaders(true);
    var url =
        Uri.parse(AppConfiguration.UrlApi + EndPoint.usrUnicode + unicode);
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<dynamic> getBankTransactionById(String idTransactionBank) async {
    var header = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi +
        EndPoint.usrDepositBank +
        '/' +
        idTransactionBank);
    var response = await cliente.get(url, headers: header);
    return response;
  }

  Future<dynamic> updateBankTransaction(int id, String body) async {
    var header = await getHeaders(true);
    var url = Uri.parse(AppConfiguration.UrlApi +
        EndPoint.usrDepositBank +
        '/' +
        id.toString());
    var response = await cliente.put(url, headers: header, body: body);
    return response;
    // var url = Uri.parse(AppConfiguration.UrlApi + EndPoint.usrDepositBank);
    // var response = await cliente.get(url, headers: header);
    // return response;
  }

  Future<UnblockTransactionsResponse> getUnblockTransactions({
    String? dateStart,
    String? dateEnd,
    String? coinId,
    String? operationCode,
    required int takeQuery,
    required int pageQuery,
  }) async {
    var queryParameters = {
      'dateStart': dateStart == null ? '' : dateStart.toString(),
      'dateEnd': dateEnd == null ? '' : dateEnd.toString(),
      'idCoin': coinId == null ? '' : coinId.toString(),
      'codeOper': operationCode == null ? '' : operationCode.toString(),
      'takeQuery': takeQuery.toString(),
      'pageQuery': pageQuery.toString(),
    };

    var uri = Uri.https(
      AppConfiguration.apiAuthority,
      EndPoint.unblockTransactions,
      queryParameters,
    );

    _logger.i(uri);

    var httpResponse = await cliente.get(
      uri,
      headers: await getHeaders(true),
    );

    if (httpResponse.statusCode != 200) {
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error. Connection error
    }

    final bodyJson = jsonDecode(httpResponse.body) as Map<String, dynamic>;
    if (!bodyJson.containsKey('data')) {
      //Throws no data exception
    }

    if (bodyJson["codeError"] != 0) {
      //Some internal error
    }

    //Logger().d(httpresponse.body);
    //log(httpResponse.body);

    final unblockTransactionsResponse =
        unblockTransactionsResponseFromMap(httpResponse.body);
    return unblockTransactionsResponse;
  }

  Future<List<CryptoCoin>> getAvailableCryptoCoins() async {
    //Logger().d('Api Service Get Available Fiat');
    var httpresponse = await cliente.get(
        Uri.parse(
          AppConfiguration.UrlApi + EndPoint.availableCryptoCoins,
        ),
        headers: await getHeaders(true));

    if (httpresponse.statusCode != 200) {
      //TODO: Imeplement API errror Exceptions.
      //Throws bad response error.
    }

    final bodyJson = jsonDecode(httpresponse.body) as Map<String, dynamic>;
    if (!bodyJson.containsKey('data')) {
      //Throws no data exception
    }

    if (bodyJson["codeError"] != 0) {
      //Some internal error
    }

    //Logger().d(httpresponse.body);
    final AvailableCryptoCoinsResponse availableCryptoCoinsResponse =
        availableCryptoCoinsResponseFromMap(httpresponse.body);

    return availableCryptoCoinsResponse.cryptoCoinList;
  }*/
}
