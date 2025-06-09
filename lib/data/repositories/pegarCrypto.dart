import 'package:api_coin_market/core/library/extensions.dart';
import 'package:api_coin_market/data/datasources/data_source.dart';
import 'package:api_coin_market/domain/entities/core/http_resonse_entity.dart';
import 'package:api_coin_market/domain/entities/moeda/Crypto_entity.dart';

abstract interface class ICoinRepository {

Future<List<Crypto>> getCriptoMoeda();
}

final class Coin implements ICoinRepository {
  final IRemoteDataSource _remoteDataSource;

  const Coin(this._remoteDataSource);

  @override
Future<List<Crypto>> getCriptoMoeda() async {
  final HttpResponseEntity httpResponse = (await _remoteDataSource.get(_urlMoeda))!;

  final List<dynamic> lista = (httpResponse.data as Map<String, dynamic>)['data'];
  return lista.map((e) => Crypto.fromMap(e)).toList();
}


  String get _urlMoeda => _remoteDataSource.environment?.urlMoeda ?? '';
  
} 