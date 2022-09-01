import 'package:currency_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bloc/bloc.dart';
import 'screens/currency/controller.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff333333),
      systemNavigationBarDividerColor: Color(0xff333333),
    ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CurrencyBloc()),
        BlocProvider(create: (context) => TimeseriesBloc()),
      ],
      child: const Init(),
    ),
  );
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: CurrencyScreen(),
        );
      },
    );
  }
}
