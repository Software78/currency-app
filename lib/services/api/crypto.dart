import 'dart:convert';

import 'package:currency_app/models/response_model.dart';
import 'package:currency_app/utils/utils.dart' show get, Response;

class Currency {
  final String _url = 'https://api.frankfurter.app';

  Future<CurrencyResponse> getCurrency() async {
    Response response = await get(Uri.parse('$_url/latest?from=USD'));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['rates'];
      return CurrencyResponse(status: true, data: result);
    } else {
      return CurrencyResponse(status: false, message: 'an error occured');
    }
  }

  Future<TimeSeriesResponse> getTimeSeries(String currency) async {
    Response response = await get(
        Uri.parse('$_url/2022-08-01..2022-08-30?from=USD&to=$currency'));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body)['rates'];
      print(result);
      return TimeSeriesResponse(status: true, data: result);
    } else {
      return TimeSeriesResponse(status: false, message: 'an error occured');
    }
  }
}
