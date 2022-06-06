import 'package:fit_tracker/app/data/model/user_track_model.dart';
import 'package:fit_tracker/app/modules/home/controllers/home_controller.dart';
import 'package:fit_tracker/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeChart extends GetView<HomeController> {
  const HomeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          27, 27 + MediaQuery.of(context).padding.top + kToolbarHeight, 27, 27),
      padding: EdgeInsets.all(
        27,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Obx(
        () {
          return SfCartesianChart(
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
              majorTickLines: MajorTickLines(
                width: 0,
              ),
              labelPlacement: LabelPlacement.onTicks,
              majorGridLines: MajorGridLines(width: 0),
              axisLine: AxisLine(
                width: 3,
                color: appThemeData.primaryColor,
              ),
            ),
            primaryYAxis: NumericAxis(
              majorTickLines: MajorTickLines(
                width: 0,
              ),
              majorGridLines: MajorGridLines(width: 0),
              axisLine: AxisLine(
                width: 3,
                color: appThemeData.primaryColor,
              ),
            ),
            legend: Legend(isVisible: false),
            tooltipBehavior: TooltipBehavior(
                enable: true,
                color: Color(0xFFFFFF).withOpacity(1),
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                borderColor: Color(0xE0E0E0).withOpacity(1),
                borderWidth: 0,
                header: '',
                format: 'point.x\npoint.y kg'),
            plotAreaBorderWidth: 0,
            series: <CartesianSeries>[
              AreaSeries<UserTrack, String>(
                name: 'Weight',
                markerSettings:
                    MarkerSettings(isVisible: false, borderWidth: 0),
                dataLabelSettings: DataLabelSettings(isVisible: false),
                dataSource: controller.listTrack.reversed.toList(),
                xValueMapper: (UserTrack track, _) =>
                    Jiffy(track.date).format('dd MMM yy'),
                yValueMapper: (UserTrack track, _) => track.weight,
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.transparent,
                    appThemeData.primaryColor.withAlpha(30),
                  ],
                  stops: [
                    0.025,
                    1.0,
                  ],
                ),
                animationDuration: 1,
                borderColor: appThemeData.primaryColor,
                borderWidth: 1,
                opacity: 1.0,
              ),
              LineSeries<UserTrack, String>(
                name: 'Date',
                markerSettings: MarkerSettings(isVisible: true, borderWidth: 2),
                animationDuration: 1,
                dataLabelSettings: DataLabelSettings(isVisible: false),
                dataSource: controller.listTrack.reversed.toList(),
                xValueMapper: (UserTrack track, _) =>
                    Jiffy(track.date).format('dd MMM yy'),
                yValueMapper: (UserTrack track, _) => track.weight,
                color: appThemeData.primaryColor,
                width: 3,
                opacity: 1.0,
              )
            ],
          );
        },
      ),
    );
  }
}
