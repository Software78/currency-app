import 'package:currency_app/models/currency_model.dart';

class CurrencyResponse {
  final bool status;
  final Map<String, dynamic>? data;
  final String? message;

  CurrencyResponse({
    required this.status,
    this.data,
    this.message,
  });
}

class TimeSeriesResponse {
  final bool status;
  final Map<String,dynamic>? data;
  final String? message;

  TimeSeriesResponse({
    required this.status,
    this.data,
    this.message,
  });
}

class TimeSeries {
  final String date;
  final CurrencyData data;

  TimeSeries({
    required this.date,
    required this.data,
  });
}
