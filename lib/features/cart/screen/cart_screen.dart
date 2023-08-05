import 'package:amazon_clone_flutter/common/widgets/custom_button.dart';
import 'package:amazon_clone_flutter/features/address/screen/address_screen.dart';
import 'package:amazon_clone_flutter/features/admin/screen/add_product_screen.dart';
import 'package:amazon_clone_flutter/features/auth/home/widget/addres_box.dart';
import 'package:amazon_clone_flutter/features/cart/widget/cart_product.dart';
import 'package:amazon_clone_flutter/features/cart/widget/cart_subtotal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/globalVariables.dart';
import '../../../provider/user_provider.dart';
import '../../search/screen/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigationToShearch(String qurey) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: qurey);
  }

  void navigationToAddres(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

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
          child: Column(
        children: [
          AddressBox(),
          CartSubtotal(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomeButton(
                color: Colors.yellow[600],
                text: "proceed to Buy(${user.cart.length} items)",
                onTab: () {
                  navigationToAddres(sum);
                }),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          SizedBox(
            height: 5,
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: user.cart.length,
            itemBuilder: (context, index) {
              return CartPrduct(index: index);
            },
          )
        ],
      )),
    );
  }
}
