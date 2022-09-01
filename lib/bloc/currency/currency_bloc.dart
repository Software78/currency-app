import 'package:bloc/bloc.dart';
import 'package:currency_app/models/response_model.dart';
import 'package:currency_app/services/repository.dart';
import 'package:equatable/equatable.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyLoading()) {
    on<LoadCurrencies>((event, emit) => _loadCurrencies(event, emit));
    on<LoadCoins>((event, emit) => _loadCoins(event, emit));
  }

  _loadCurrencies(event, emit) async {
    emit(CurrencyLoading());
    CurrencyResponse response = await Repository.instance.loadCurrencyData();
    response.status
        ? emit(CurrencyLoaded(data: response.data!))
        : emit(CurrencyError(message: response.message!));
  }

  _loadCoins(event, emit) {}
}
