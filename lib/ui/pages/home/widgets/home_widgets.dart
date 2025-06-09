import 'package:api_coin_market/domain/entities/core/request_state_entity.dart';
import 'package:api_coin_market/domain/entities/moeda/Crypto_entity.dart';
import 'package:api_coin_market/ui/pages/home/view_models/tela_home_viewmodel.dart';
import 'package:api_coin_market/utils/util_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_coin_market/configs/factory_viewmodel.dart';
import 'package:api_coin_market/utils/util_text.dart';
import 'package:intl/intl.dart';


class HomeWidgets extends StatefulWidget {
  const HomeWidgets({super.key});

  @override
  State<HomeWidgets> createState() => _HomeWidgetsState();
}

class _HomeWidgetsState extends State<HomeWidgets> {
  late final TelaHomeViewModel _TelaHomeViewModel;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _TelaHomeViewModel = context.read<TelaHomeViewModel>();
    _TelaHomeViewModel.pegarCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Buscar cripto (ex: BTC, ETH, SOL)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _buscarMoeda,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 84, 249),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                child: const Text('BUSCAR', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(thickness: 2, color: Color.fromARGB(255, 0, 0, 0)),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<TelaHomeViewModel, IRequestState<List<Crypto>>>(
              builder: (context, state) {
                if (state is RequestProcessingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is RequestCompletedState) {
                  final listaMoedas = state.data;
                  return RefreshIndicator(
                    onRefresh: () async {
                      _TelaHomeViewModel.pegarCrypto();
                    },
                    child: ListView.builder(
                      itemCount: listaMoedas.length,
                      itemBuilder: (context, index) {
                        final moeda = listaMoedas[index];
                        return InkWell(
                          onTap: () => _mostrarDetalhesMoeda(context, moeda),
                          child: CamposDaMoeda(
                            nome: moeda.name,
                            sigla: moeda.symbol,
                            valorUSD: formatadorUSD.format(moeda.price),
                            valorBRL: formatadorBRL.format(moeda.price * 5.73),
                          ),
                        );
                      },
                    ),
                  );
                }

                return const Center(child: Text('Nenhuma moeda encontrada'));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _buscarMoeda() {
    final symbols = formatarSimbolos(_controller.text);
    final lista = symbols.isEmpty ? todasMoedas : symbols;
    _TelaHomeViewModel.buscarCrypto(lista);
  }
}

class CamposDaMoeda extends StatelessWidget {
  final String nome;
  final String sigla;
  final String valorUSD;
  final String valorBRL;

  const CamposDaMoeda({
    super.key,
    required this.nome,
    required this.sigla,
    required this.valorUSD,
    required this.valorBRL,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(sigla, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Valor USD:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  Text('Valor BRL:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(valorUSD, style: const TextStyle(fontSize: 15)),
                  Text(valorBRL, style: const TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _mostrarDetalhesMoeda(BuildContext context, Crypto coin) {
  final formatadorUSD = NumberFormat.currency(locale: 'en_US', symbol: 'US\$');
  final formatadorBRL = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: Colors.white,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(coin.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Símbolo: ${coin.symbol}'),
            Text('Data adicionada: ${formatarData(coin.date_added)}'),
            const SizedBox(height: 12),
            Text('Preço atual USD: ${formatadorUSD.format(coin.price)}'),
            Text('Preço atual BRL: ${formatadorBRL.format(coin.price * 5.73)}'),
          ],
        ),
      );
    },
  );
}


