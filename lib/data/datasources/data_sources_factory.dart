
import 'package:api_coin_market/configs/environment_helper.dart';
import 'package:api_coin_market/configs/injection_container.dart';
import 'package:api_coin_market/core/service/http_service.dart';
import 'package:api_coin_market/data/datasources/data_source.dart';
import 'package:api_coin_market/data/datasources/remote_datasource.dart';

final class RemoteFactoryDataSource {
  IRemoteDataSource create() {
    final IHttpService httpService = HttpServiceFactory().create();
    final IEnvironmentHelper environmentHelper = getIt<IEnvironmentHelper>();
    return RemoteDataSource(
      httpService, 
      environmentHelper, 
    );
  }
}