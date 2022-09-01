import 'package:currency_app/utils/utils.dart';

class Preferences {
  final String currency = 'Currency';

  Future<SharedPreferences> prefs() async {
    return await SharedPreferences.getInstance();
  }

  setCurrencyPref() async {
    await prefs().then((value) => value.setBool(currency, true));
  }

  setCryptoPref() async {
    await prefs().then((value) => value.setBool(currency, true));
  }
}
