import 'package:currency_app/screens/timeseries/controller.dart';
import 'package:currency_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../bloc/bloc.dart';
import 'view.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyScreen> createState() => CurrencyController();
}

class CurrencyController extends State<CurrencyScreen> {
  @override
  void initState() {
    context.read<CurrencyBloc>().add(LoadCurrencies());
    super.initState();
  }

  List dropdownItemList = [
    {'label': 'Fiat', 'value': 'Fiat'}, // label is required and unique
    {'label': 'Crypto', 'value': 'Crypto'},
  ];

  navigate(String currency) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TimeSeriesScreen(
                  currency: currency,
                )));
  }

  Widget currencyWidget(
      {required String title, required String symbol, required String value}) {
    return SizedBox(
      height: 48.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: const Color(0xff4ED46C),
            child: Text(
              symbol,
              style: GoogleFonts.mulish(
                textStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: SizedBox()),
              Text(
                title,
                style: GoogleFonts.mulish(
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
              Text(
                symbol,
                style: GoogleFonts.mulish(
                  textStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const Expanded(child: SizedBox()),
          Text(
            value,
            style: GoogleFonts.mulish(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B6B6B),
              ),
            ),
          ),
          SizedBox(width: 60.w),
          Text(
            '10.4%',
            style: GoogleFonts.mulish(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff4ED46C),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CurrencyView(this);
  }
}
