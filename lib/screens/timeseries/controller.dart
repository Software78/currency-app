// ignore_for_file: must_be_immutable

import 'package:currency_app/models/currency_model.dart';
import 'package:currency_app/models/request_model.dart';
import 'package:flutter/material.dart';

import '../../bloc/bloc.dart';
import '../../utils/utils.dart';
import 'view.dart';

class TimeSeriesScreen extends StatefulWidget {
  TimeSeriesScreen({
    Key? key,
    required this.currency,
  }) : super(key: key);

  String currency;

  @override
  State<TimeSeriesScreen> createState() => TimeSeriesController();
}

class TimeSeriesController extends State<TimeSeriesScreen> {
  List dropdownItemList = List.generate(
    currencies.length,
    (index) => {
      'label': currencies.keys.toList()[index],
      'value': currencies.keys.toList()[index],
    },
  );

  // [
  //   {'label': 'NGN', 'value': 'NGN'},
  //   {'label': 'USD', 'value': 'USD'},
  //   {'label': 'AUD', 'value': 'AUD'},
  //   {'label': 'GBP', 'value': 'GBP'},
  //   {'label': 'CNY', 'value': 'CNY'},
  // ];

  back() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    context.read<TimeseriesBloc>().add(
          LoadTimeSeries(
            model: TimeSeriesRequestModel(
              currency: widget.currency,
            ),
          ),
        );
    super.initState();
  }

  Widget currencyWidget() {
    return SizedBox(
      height: 48.h,
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: const Color(0xff4ED46C),
            child: Text(
              'NGN',
              style: GoogleFonts.mulish(
                textStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: SizedBox()),
              Text(
                'Naira',
                style: GoogleFonts.mulish(
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6B6B6B),
                  ),
                ),
              ),
              Text(
                'NGN',
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
          SizedBox(width: 125.w),
          Text(
            '1',
            style: GoogleFonts.mulish(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B6B6B),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
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
    return Scaffold(
      body: BlocBuilder<TimeseriesBloc, TimeseriesState>(
        builder: (context, state) {
          if (state is TimeseriesLoading) {
            return (const Center(
              child: CircularProgressIndicator(),
            ));
          }
          if (state is TimeSeriesError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is TimeSeriesLoaded) {
            return TimeSeriesView(
              this,
              state: state,
            );
          }
          return Container();
        },
      ),
    );
  }
}
