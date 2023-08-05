// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:amazon_clone_flutter/models/sales.dart';

class CatgoryProductChart extends StatelessWidget {
  CatgoryProductChart({
    Key? key,
    required this.series,
  }) : super(key: key);
  final List<charts.Series<Sales, String>> series;
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
