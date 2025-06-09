import 'package:flutter/material.dart';

export 'package:flutter/material.dart';
export 'package:api_coin_market/configs/environment_helper.dart';
export 'package:api_coin_market/configs/factory_viewmodel.dart';
export 'package:api_coin_market/configs/injection_container.dart';


abstract interface class IFactoryViewModel<T> {
  T create(BuildContext context);
  void dispose(BuildContext context, T viewModel);
}