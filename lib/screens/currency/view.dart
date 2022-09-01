import 'package:currency_app/bloc/currency/currency_bloc.dart';
import 'package:currency_app/models/currency_model.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'controller.dart';

class CurrencyView extends StatelessView<CurrencyScreen, CurrencyController> {
  const CurrencyView(CurrencyController state, {Key? key})
      : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CurrencyBloc, CurrencyState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CurrencyLoaded) {
            return SafeArea(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    RichText(
                      text: TextSpan(
                        text: 'ATS',
                        style: GoogleFonts.sora(
                          textStyle: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff609fff),
                          ),
                        ),
                        children: [
                          TextSpan(
                            text: 'Currency',
                            style: GoogleFonts.sora(
                              textStyle: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff1D1D1D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CoolDropdown(
                      dropdownList: controller.dropdownItemList,
                      onChange: (value) {
                        print(value);
                      },
                      resultWidth: 335.w,
                      dropdownHeight: 118,
                      dropdownWidth: 335.w,
                      placeholder: 'Select Currency',
                      defaultValue: controller.dropdownItemList[0],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          'Currency',
                          style: GoogleFonts.mulish(
                            textStyle: const TextStyle(
                              color: Color(0xffBDBDBD),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          'Last Price',
                          style: GoogleFonts.mulish(
                            textStyle: const TextStyle(
                              color: Color(0xffBDBDBD),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 50.w),
                        Text(
                          'Vol 24h',
                          style: GoogleFonts.mulish(
                            textStyle: const TextStyle(
                              color: Color(0xffBDBDBD),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => controller
                              .navigate(currencies.keys.toList()[index]),
                          child: controller.currencyWidget(
                            symbol: currencies.keys.toList()[index],
                            title: currencies.values.toList()[index],
                            value: state.data[currencies.keys.toList()[index]]
                                .toString(),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8.h),
                        itemCount: 15,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is CurrencyLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        child: BottomAppBar(
          color: const Color(0xff333333),
          child: SizedBox(
            height: 79,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset('assets/svg/home.svg'),
                SvgPicture.asset('assets/svg/tab2.svg'),
                SvgPicture.asset('assets/svg/tab3.svg'),
                SvgPicture.asset('assets/svg/tab4.svg'),
                SvgPicture.asset('assets/svg/tab5.svg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
