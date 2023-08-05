import 'package:amazon_clone_flutter/common/widgets/loder.dart';
import 'package:amazon_clone_flutter/features/admin/services/admin_services.dart';
import 'package:amazon_clone_flutter/features/admin/widget/category_product_chart.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalEarning;
  List<Sales>? earning;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnning(context);
    totalEarning = earningData['totalEarnings'];
    earning = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earning == null || totalEarning == null
        ? Loder()
        : Column(
            children: [
              Text(
                '\$$totalEarning',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 150,
                child: CatgoryProductChart(series: [
                  charts.Series(
                      id: 'Sales',
                      data: earning!,
                      domainFn: (Sales sales, _) => sales.lable,
                      measureFn: (Sales sales, _) => sales.earning),
                ]),
              ),
            ],
          );
  }
}
