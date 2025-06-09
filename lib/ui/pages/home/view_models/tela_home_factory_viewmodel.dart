import 'package:api_coin_market/configs/factory_viewmodel.dart';
import 'package:api_coin_market/data/datasources/data_source.dart';
import 'package:api_coin_market/data/datasources/data_sources_factory.dart';
import 'package:api_coin_market/data/repositories/BuscarCrypto.dart';
import 'package:api_coin_market/data/repositories/pegarCrypto.dart';
import 'package:api_coin_market/ui/pages/home/view_models/tela_home_viewmodel.dart';
import 'package:flutter/material.dart';

final class TelaPerfilFactoryViewmodel implements IFactoryViewModel<TelaHomeViewModel> {
  @override
  TelaHomeViewModel create(BuildContext context) {
    final IRemoteDataSource remoteDataSource = RemoteFactoryDataSource().create();
    final IEnvironmentHelper environmentHelper = const EnvironmentHelper();

    final ICoinbuscaRepository buscaRepository = buscarCrypto(remoteDataSource, environmentHelper);
    final ICoinRepository moedaRepository = Coin(remoteDataSource);
    
    return TelaHomeViewModel(moedaRepository,buscaRepository);
  }

  @override
  void dispose(BuildContext context, TelaHomeViewModel viewModel) {
    viewModel.close();
  }
}