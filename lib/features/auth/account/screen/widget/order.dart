import 'package:amazon_clone_flutter/common/widgets/loder.dart';
import 'package:amazon_clone_flutter/features/auth/account/screen/widget/single_product.dart';
import 'package:amazon_clone_flutter/features/auth/account/services/acount_services.dart';
import 'package:amazon_clone_flutter/features/order_details/screen/order_details.dart';
import 'package:amazon_clone_flutter/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<OrderList>? ordes = [];
  AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrderList();
  }

  void fetchOrderList() async {
    ordes = await accountServices.fetchOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ordes == null
        ? Loder()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Order',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      'See All',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: EdgeInsets.only(left: 10, right: 0, top: 20),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ordes!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, OrderDetailScreen.routeName,
                              arguments: ordes![index]);
                        },
                        child: SingleProduct(
                            image: ordes![index].products[0].images[0]),
                      );
                    }),
              )
            ],
          );
  }
}
