import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String month;
  String year;
  double sgpa;
  final charts.Color color;

  BarChartModel({
    this.month,
    this.year,
    this.sgpa,
    this.color,
  });
}
