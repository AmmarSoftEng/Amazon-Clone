import 'package:amazon_clone_flutter/common/widgets/custom_button.dart';
import 'package:amazon_clone_flutter/features/admin/services/admin_services.dart';
import 'package:amazon_clone_flutter/models/order.dart';
import 'package:amazon_clone_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/globalVariables.dart';
import '../../search/screen/search_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  OrderDetailScreen({Key? key, required this.orderList}) : super(key: key);
  static const String routeName = '/order_details';
  final OrderList orderList;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  void navigationToShearch(String qurey) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: qurey);
  }

  final AdminServices adminServices = AdminServices();

  int currentStep = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep = widget.orderList.status;
  }

  void changeOrderStatus(int status) {
    adminServices.status(
        context: context,
        order: widget.orderList,
        status: status + 1,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(17),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigationToShearch,
                      decoration: InputDecoration(
                        prefix: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        hintText: 'Search Amazon',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                        // prefixIcon: Icon(Icons.search,color: Colors.black,size: 22,),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.transparent,
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 23,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View order details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.topLeft,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date:        ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.orderList.orderedAt))}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Order Id:             ${widget.orderList.id}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Total Price:         \$${widget.orderList.totalPrice}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Purchase details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.orderList.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.orderList.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.orderList.products[i].name,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Qty: ${widget.orderList.quantity[i].toString()}',
                              ),
                            ],
                          ))
                        ],
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: ((context, details) {
                    if (user.types == 'admin') {
                      return CustomeButton(
                        text: 'Done',
                        onTab: () => changeOrderStatus(details.currentStep),
                      );
                    }
                    return SizedBox();
                  }),
                  steps: [
                    Step(
                        title: Text('Pending'),
                        content: Text('Your order is yet to be delivered'),
                        isActive: currentStep > 0,
                        state: currentStep > 0
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: Text('Completed'),
                        content: Text(
                            'Your order has been delivered, you are yet to sign.'),
                        isActive: currentStep > 1,
                        state: currentStep > 1
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: Text('Received'),
                        content: Text(
                            'Your order has been delivered, you are yet to sign by you. '),
                        isActive: currentStep > 2,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: Text('Delivered'),
                        content: Text(
                            'Your order has been delivered, you are yet to sign by you. '),
                        isActive: currentStep >= 3,
                        state: currentStep >= 3
                            ? StepState.complete
                            : StepState.indexed),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
