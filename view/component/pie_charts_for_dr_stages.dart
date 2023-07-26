import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/view/component/text_comp.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../app/core/styles/app_color.dart';
import '../home/home_screen.dart';

class ChartDrStages extends StatefulWidget {
  const ChartDrStages({
    super.key,
  });

  @override
  State<ChartDrStages> createState() => _ChartDrStagesState();
}

class _ChartDrStagesState extends State<ChartDrStages> {
  late List<GDPData> getDRStages = _getChartData();

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      margin: const EdgeInsets.all(0),
      title: ChartTitle(
          text: "Distribution Stages of DR",
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 14.0,fontWeight: FontWeight.w500)),
      legend: Legend(
        isVisible: true,
      ),
      series: <CircularSeries>[
        PieSeries<GDPData, String>(
            dataSource: getDRStages,
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
      GDPData(content: "No Dr", gdp: 55),
      GDPData(content: "Mild", gdp: 9),
      GDPData(content: "Moderate", gdp: 11),
      GDPData(content: "Severe", gdp: 13),
      GDPData(content: "PDR", gdp: 12)
    ];
    return gdpData;
  }
}
