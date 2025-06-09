import 'package:api_coin_market/configs/environment_helper.dart';
import 'package:api_coin_market/core/library/extensions.dart';
import 'package:api_coin_market/data/datasources/data_source.dart';
import 'package:api_coin_market/domain/entities/core/http_resonse_entity.dart';
import 'package:api_coin_market/domain/entities/moeda/Crypto_entity.dart';

abstract interface class ICoinbuscaRepository {
  Future<List<Crypto>> getCriptoMoedasymbol(List<String> simbolos);
}

final class buscarCrypto implements ICoinbuscaRepository {
  final IRemoteDataSource _remoteDataSource;
  final IEnvironmentHelper _environment;

  const buscarCrypto(this._remoteDataSource, this._environment);

  @override
  Future<List<Crypto>> getCriptoMoedasymbol(List<String> simbolos) async {
    final url = montarUrlComSimbolos(simbolos, _environment);
    final HttpResponseEntity httpResponse = (await _remoteDataSource.get(url))!;

    final Map<String, dynamic> dados = httpResponse.data as Map<String, dynamic>;
    final List<Crypto> Coin = [];

   
    dados['data'].forEach((symbol, item) {
      Coin.add(Crypto.fromMap(item));
    });

    return Coin;
  }
}

String montarUrlComSimbolos(List<String> simbolos, IEnvironmentHelper environment) {
  final simbolosFormatados = simbolos.map((e) => e.trim().toUpperCase()).join(',');
  return '${environment.urlMoedasimbolo}$simbolosFormatados';
}