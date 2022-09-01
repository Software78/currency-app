import 'package:currency_app/models/request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/bloc.dart';
import '../../utils/utils.dart';
import 'controller.dart';

class TimeSeriesView
    extends StatelessView<TimeSeriesScreen, TimeSeriesController> {
  const TimeSeriesView(TimeSeriesController controller,
      {Key? key, required this.state})
      : super(controller, key: key);

  final TimeSeriesLoaded state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: REdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () => controller.back(),
                    child: const Icon(Icons.arrow_back_ios)),
                const Expanded(child: SizedBox()),
                CircleAvatar(
                  radius: 17,
                  backgroundColor: const Color(0xff4ED46C),
                  child: Text(
                    controller.widget.currency,
                    style: GoogleFonts.mulish(
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  '${controller.widget.currency}/USD',
                  style: GoogleFonts.mulish(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff444444),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                SvgPicture.asset('assets/svg/icon.svg'),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CoolDropdown(
              dropdownList: controller.dropdownItemList,
              onChange: (value) {
                widget.currency = value['label'];
                context.read<TimeseriesBloc>().add(LoadTimeSeries(
                    model: TimeSeriesRequestModel(currency: value['label'])));
              },
              resultWidth: 335.w,
              dropdownHeight: 300.h,
              dropdownWidth: 335.w,
              defaultValue: controller.dropdownItemList[0],
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: 186.w,
              height: 60.h,
              child: Row(
                children: [
                  const VerticalDivider(
                    color: Color(0xff27AE60),
                    thickness: 6,
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1/${state.data.values.toList()[0][widget.currency].toString()}',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svg/icons.svg'),
                          Text(
                            '105(0.8%)',
                            style: GoogleFonts.mulish(
                              textStyle: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff27AE60),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              //width: double.infinity,
              height: 300.h,
              child: BlocBuilder<TimeseriesBloc, TimeseriesState>(
                builder: (context, state) {
                  if (state is TimeSeriesLoaded) {
                    return LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(),
                          topTitles: AxisTitles(),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            color: const Color(0xff27AE60),
                            barWidth: 2,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xff27AE60).withOpacity(0.3),
                                  Colors.white,
                                ],
                              ),
                              show: true,
                            ),
                            spots: List.generate(
                              state.data.length,
                              (index) => FlSpot(
                                double.parse(
                                  state.data.keys
                                      .toList()[index]
                                      .toString()
                                      .substring(8),
                                ),
                                double.parse(
                                  state.data.values
                                      .toList()[index][widget.currency]
                                      .toString(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 150),
                      swapAnimationCurve: Curves.linear,
                    );
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(height: 12.h),
            Center(
              child: CupertinoButton.filled(
                child: const Text('Add to watchlist'),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 22.h),
            Row(
              children: const [
                Text('Quick watch'),
                Expanded(child: SizedBox()),
                Text('See all'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => controller.currencyWidget(),
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
