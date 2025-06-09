import 'package:api_coin_market/ui/pages/home/view_models/tela_home_factory_viewmodel.dart';
import 'package:api_coin_market/ui/pages/home/view_models/tela_home_viewmodel.dart';
import 'package:api_coin_market/ui/pages/home/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TelaHomeViewModel>(
      create: TelaPerfilFactoryViewmodel().create,
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 43, 231),
        title: const Text(
          'Mercado Cripto',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: HomeWidgets(),
    );
  }
}