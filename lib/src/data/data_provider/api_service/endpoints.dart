class EndPoint {
  static const String pathMobile = 'mobile/v1/and';

  static const String getAllDeposit = '$pathMobile/deposit/getDeposit';
  static const String getDeposit = '$pathMobile/deposit/getDeposit?idCompany=';
  static const String createDeposit = '$pathMobile/deposit/createDeposit';
  static const String updateDeposit = '$pathMobile/deposit/updateDeposit';
  static const String deleteDeposit = '$pathMobile/deposit/deleteDeposit';

  static const String login = '/auth/signin-internal-user';
  static const String logout = '/auth/signout-internal-user/';
  static const String merchants = '/com-main/get-all-with-wallet';
  static const String merchantsDetail = '/com-main';
  static const String merchantContact = '/com-contacts/get-by-comerce';
  static const String merchantComments = '/com-comments/all-by-commerce/';
  static const String merchantPostComments =
      '/com-comments/create-comment-commerce';
  static const String userGetComments = '/com-comments/all-by-user/';
  static const String userPostComments = '/com-comments/create-comment-user';
  static const String users = '/usr-main/get-all-with-wallet';
  static const String userDetail = '/usr-main';
  static const String userChangePassword = '/usr-main/reset-password';
  static const String userLimits = '/usr-limit/get-by-id-user/';
  static const String dailyLimits = '/usr-limit/get-daily-limit?idUser=';
  static const String userCosts = '/usr-costs/get-by-id-user/';
  static const String updateLimit = '/usr-limit/';
  static const String updateCosts = '/usr-costs/';

  static const String cryptoUserById =
      '/com-account-movements/get-my-cryptos?idUser=';

  static const String countries = '/cfg-country/countries-enabled';
  static const String countryByCode = '/cfg-country/get-country-by-code/';
  static const String companies = '/cfg-company-binary';
  static const String moneyNoCrypto = '/cfg-money/fiat';
  static const String companiesCountries =
      '/cfg-company-binary-country/get-by-idcompany?idCompany=';
  static const String companiesBankAccounts =
      '/cfg-company-bank-accounts/country-and-company?idCompany=';
  static const String companiesLimits =
      '/cfg-company-binary-limits/get-by-company/';
  static const String companyLimit = '/cfg-company-binary-limits';
  static const String companyCost = '/cfg-company-binary-costs';
  static const String companyCountry = '/cfg-company-binary-country';
  static const String companyBankAccount = '/cfg-company-bank-accounts';
  static const String companiesCosts =
      '/cfg-company-binary-costs/get-by-company/';
  static const String totalBalanceUser =
      '/com-account-movements/balance?idUser=';
  static const String merchantContactSave = '/com-contacts';
  static const String merchantBalance =
      '/com-account-movements/balance-commerce?idCommerce=';
  static const String merchantCrypto =
      '/com-account-movements/get-cryptos-by-commerce?idCommerce=';
  static const String merchantSettlement = '/com-fund-request?idCommerce=';
  static const String merchantTypes = '/cfg-com-type';

  static const String merchantsMovements =
      'com-account-movements/commerce?idCommerce=';
  static const String usersMovements = 'com-account-movements/get-by-user';
  static const String stableCoins = '/cfg-money/stablecoin';
  static const String officerAccount = '/internal-user/officer-account/';
  static const String cryptoBridge = '/crypto-bridge';
  static const String getCryptosBridges = '/crypto-bridge/get-by-merchant/';
  static const String getCryptoBridge = '/crypto-bridge/';
  static const String putCryptoBridge = '/crypto-bridge/';

  static const String limits = '/cfg-limits';
  static const String costs = '/cfg-costs?status=1';
  static const String banks = '/cfg-banks';
  static const String getUserFiles = '/usr-document/document-by-user?idUser=';
  static const String getUserFilesFilteredByName =
      '/usr-document/document-by-user-and-category';
  static const String getUserFileCategories = '/cfg-usr-category?idUser=';
  static const String createNewUserCategory = '/cfg-usr-category';
  static const String createNewFile = '/usr-document';

  /**Country Catalog */
  static const String getCountryCatalog = '/cfg-country';
  static const String getHighRiskCountryCatalog = '/cfg-high-risk-countries';
  static const String getBlackListedCountryCatalog = '/cfg-blacklist-countries';
  static const String getEnabledCountries = '/cfg-country/countries-enabled';
  static const String getAvailableFiat = '/cfg-money/fiat';

  static const String createNewCountry = '/cfg-country';
  static const String addCountryToHighRisk = '/cfg-high-risk-countries';
  static const String addCountryToBlackListed = '/cfg-blacklist-countries';
  static const String modifyCountry = '/cfg-country/';

  static const String deleteHighRisk = '/cfg-high-risk-countries';
  static const String deleteBlackListed = '/cfg-blacklist-countries';
  //internal users
  static const String internalUser = '/internal-user';
  static const String internalUserChangePassword =
      '/internal-user/reset-password';
  //Swift
  static const String getSwift = '/cfg-swift/get-bank-by-swift/';

  //
  static const String costsWithOutFilter = '/cfg-costs';
  static const String limitsWithOutFilter = '/cfg-limits';

  //money
  static const String cryptoSettings = '/cfg-money/get-all';
  static const String cryptoSettingsPos = '/cfg-money';
  static const String coinType = '/cfg-coin-type';
  static const String fiat = '/cfg-money/fiat';
  //request funds
  static const String fundsRequest = '/com-fund-request';

  // Deposit Bank
  static const String usrDepositBank = '/usr-deposit-bank';
  // Deposit Bank
  static const String usrUnicode = '/usr-main/get-user-by-unique-code/';

  //Unblock Transactions
  static const String unblockTransactions = '/com-account-movements';
  static const String availableCryptoCoins = '/cfg-money';
}
