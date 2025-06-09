abstract interface class IEnvironmentHelper {
  String? get urlMoeda;
  String? get urlMoedasimbolo;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();


  String get _urlBase => 'https://pro-api.coinmarketcap.com';

  @override
  String? get urlMoeda => '$_urlBase/v1/cryptocurrency/listings/latest';
  
  @override
  String? get urlMoedasimbolo => '$_urlBase/v1/cryptocurrency/quotes/latest?symbol=';


}

final String apiKey = 'e83b0e25-a881-42ca-8a54-c7062d2d7741';