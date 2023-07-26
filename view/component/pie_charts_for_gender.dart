import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/view/component/text_comp.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../app/core/styles/app_color.dart';
import '../home/home_screen.dart';

class ChartDrAmongGender extends StatefulWidget {
  const ChartDrAmongGender({
    super.key,
  });

  @override
  State<ChartDrAmongGender> createState() => _ChartDrAmongGenderState();
}

class _ChartDrAmongGenderState extends State<ChartDrAmongGender> {
  late List<GDPData> getGender = _getChartData();

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      margin: const EdgeInsets.all(0),
      title: ChartTitle(
          text: "Distribution DR among Gender",
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 14.0,fontWeight: FontWeight.w500)),
      legend: Legend(
        isVisible: true,
      ),
      series: <CircularSeries>[
        PieSeries<GDPData, String>(
            dataSource: getGender,
            xValueMapper: (GDPData data, _) => data.content,
            yValueMapper: (GDPData data, _) => data.gdp,
            legendIconType: LegendIconType.circle,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              builder: (dynamic data, dynamic point, dynamic series,
                  int pointIndex, int seriesIndex) {
                return ReusableText(
                  text: "${data.gdp}%",
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 13.0, color: AppColors.whiteColor,fontWeight: FontWeight.w500),
                );
              },
            )),
      ],
    );
  }

  List<GDPData> _getChartData() {
    final List<GDPData> gdpData = [
      GDPData(content: "Males", gdp: 49),
      GDPData(content: "Female", gdp: 51),
    ];
    return gdpData;
  }
}
