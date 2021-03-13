import 'package:IIIT_Surat_Connect/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:IIIT_Surat_Connect/results/bar_chart_graph.dart';
import 'package:IIIT_Surat_Connect/results/bar_chart_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartDemo extends StatefulWidget {
  @override
  _BarChartDemoState createState() => _BarChartDemoState();
}

class _BarChartDemoState extends State<BarChartDemo> {
  final List<BarChartModel> data = [
    BarChartModel(
      year: "1",
      sgpa: 9.09,
      color: charts.ColorUtil.fromDartColor(pc),
    ),
    BarChartModel(
      year: "2",
      sgpa: 9.38,
      color: charts.ColorUtil.fromDartColor(pc),
    ),
    BarChartModel(
      year: "3",
      sgpa: 8.59,
      color: charts.ColorUtil.fromDartColor(pc),
    ),
    BarChartModel(
      year: "4",
      sgpa: 9.5,
      color: charts.ColorUtil.fromDartColor(pc),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          BarChartGraph(
            data: data,
          ),
        ],
      ),
    );
  }
}
