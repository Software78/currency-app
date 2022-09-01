import 'package:currency_app/models/response_model.dart';
import 'package:currency_app/services/api/crypto.dart';

class Repository {
  Repository._privateConstructor();

  static Repository instance = Repository._privateConstructor();

  final Currency _currency = Currency();

  Future<CurrencyResponse> loadCurrencyData() async {
    return await _currency.getCurrency();
  }

  Future<TimeSeriesResponse> loadTimeSeriesData(String currency) async {
    return await _currency.getTimeSeries(currency);
  }
}
