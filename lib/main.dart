import 'package:api_coin_market/configs/injection_container.dart' as injector;
import 'package:api_coin_market/core/service/IApp_service.dart';

import 'package:api_coin_market/ui/pages/home/home_Page.dart';
import 'package:api_coin_market/ui/pages/home/view_models/tela_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.init();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: injector.getIt<IAppService>().navigatorKey,

      title: 'App Criptomoeda',
      debugShowCheckedModeBanner: false,
      home: BlocProvider<TelaHomeViewModel>(
        create: (context) => injector.getIt<TelaHomeViewModel>(),
        child: const HomePage(),
    )
    );
  }
}