import 'package:api_coin_market/data/repositories/pegarCrypto.dart';
import 'package:api_coin_market/data/repositories/BuscarCrypto.dart';
import 'package:api_coin_market/domain/entities/moeda/Crypto_entity.dart';
import 'package:api_coin_market/configs/factory_viewmodel.dart';
import 'package:api_coin_market/core/widgets/show_dialog_widget.dart';
import 'package:api_coin_market/utils/util_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_coin_market/domain/entities/core/request_state_entity.dart';


final class TelaHomeViewModel extends Cubit<IRequestState<List<Crypto>>> {
  final ICoinRepository _repository;
  final ICoinbuscaRepository _buscarepository;
  
  TelaHomeViewModel(this._repository, this._buscarepository) : super(const RequestInitiationState());

 
 
 
  void pegarCrypto() async {
    try {
      _emitter(RequestProcessingState());

      final List<Crypto> cripmoedas = await _repository.getCriptoMoeda();
      _emitter(RequestCompletedState(value: cripmoedas));
    } catch (error) {
 



  final String erorrDescription = _createErrorDescription(error);
  showSnackBar(erorrDescription);
  _emitter(RequestErrorState(error: error));
}
  }

  String _createErrorDescription(Object? error) {
    return UtilText.labelmoedaTitle;
     

  }



 
  void buscarCrypto(List<String> simbolos) async {
    try {
      _emitter(RequestProcessingState());

      final List<Crypto> cripmoedas = await _buscarepository.getCriptoMoedasymbol(simbolos);

      _emitter(RequestCompletedState(value: cripmoedas));

    } catch (error) {

  final String erorDescription = _createErroDescription(error);
  showSnackBar(erorDescription);
  _emitter(RequestErrorState(error: error));
}
  }

  String _createErroDescription(Object? error) {
    return UtilText.labelmoedabuscaTitle;
  }



  void _emitter(IRequestState<List<Crypto>> state) {
   if (isClosed) return;
    emit(state);
  }
  
  
}
