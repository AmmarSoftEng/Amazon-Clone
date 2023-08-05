import 'package:amazon_clone_flutter/common/widgets/loder.dart';
import 'package:amazon_clone_flutter/features/admin/services/admin_services.dart';
import 'package:amazon_clone_flutter/features/auth/account/screen/widget/single_product.dart';
import 'package:amazon_clone_flutter/features/order_details/screen/order_details.dart';
import 'package:amazon_clone_flutter/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  AdminServices adminServices = AdminServices();
  List<OrderList>? ordes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    ordes = await adminServices.fetchAllOrder(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ordes == null
        ? Loder()
        : GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: ordes!.length,
            itemBuilder: (context, index) {
              final orderData = ordes![index];
              return GestureDetector(
                onTap: (() {
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,
                      arguments: orderData);
                }),
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(image: orderData.products[0].images[0]),
                ),
              );
            },
          );
  }
}
