enum Enviroment { localhost, development, staging, qa, output }

class Settings {
  static final Enviroment enviroment = Enviroment.development;

  /*Ambiente de desarrollo*/

  static const String UrlApi = "http://localhost:4000/";

  /*static final String UrlApi = "https://killzone.mposglobal.com:7443";
  static final String apiAuthority = "killzone.mposglobal.com:7443";
  static final String UrlApiImage = "https://killzone.mposglobal.com:14443";*/

  /* *************************************/

  /*Ambiente de Qa*/
  //static final String UrlApi = "https://server.co:3443";
  //static final String apiAuthority = "apitest.server.co:3443";
  //static final String UrlApiImage = "https://apitest.server.co:14443";

  /* *************************************/

  // static final String UrlApi = "http://localhost:3000";
  // static final String UrlApiImage = "https://api.binaryswap.com:2443";

  static final bool isDebug = true; // false;
  static final bool activeDummyData = false; // false;
  static final bool activeSimulateArrival = false; // false;
  static final String apiKey = "M4n4G3rOMpQBinary6F23Swap21G"; // false;

  static final String googleApiKey = "";
  static final String zendeskIdAccount = "";
  static final String zendeskIdApp = "";

  static final String iosAppId = "";
  static final String androidAppId = "";

  static final String defaultLanguageIso = "es"; // es, en.
  static final String defaultTheme = "dark"; // light, dark.

  static final List<String> supportedLanguages = ["es", "en"];
  static final List<String> supportedThemes = ["light", "dark"];

  /*Ambiente*/
  //ruta de servidores //cambiar todas
  static final String BuildUrlApi = "https://server.com/ApiMobile/";
  static final String BuildCommerceToken = '4a514Oul';
  static final String BuildServiceToken = 'EDFC9B7A87';
  static final String BuildApiKey = 'lCVcDu3UfVGfRuK5MsetZgJGpwkc2vQn';

  /**************************************/
}
