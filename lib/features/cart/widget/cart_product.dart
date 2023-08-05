// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone_flutter/features/cart/services/cart_services.dart';
import 'package:amazon_clone_flutter/features/product_details/services/product_details_service.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class CartPrduct extends StatefulWidget {
  final int index;
  CartPrduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartPrduct> createState() => _CartPrductState();
}

class _CartPrductState extends State<CartPrduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuanity(Product product) {
    productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuanity(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Image.network(
                    product.images[0],
                    fit: BoxFit.fitWidth,
                    height: 135,
                    width: 135,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 235,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    '\$${product.price}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text('Eligible for Free Shipping'),
                ),
                Container(
                  width: 235,
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    'In Stock',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        decreaseQuanity(product);
                      },
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Icon(Icons.remove),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(quantity.toString()),
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        increaseQuanity(product);
                        print(quantity);
                      }),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
    ;
  }
}
