// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone_flutter/features/search/widget/stars.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone_flutter/models/product.dart';

class SearchProduct extends StatelessWidget {
  SearchProduct({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    // double totalRating = 0;
    // for (var i = 0; i < product.rating!.length; i++) {
    //   totalRating = totalRating + product.rating![i].rating;
    // }
    // double avgRating = 0;
    // if (totalRating != 0) {
    //   avgRating = totalRating / product.rating!.length;
    // }

    return Row(
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
              child: Stars(rating: 4),
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
    );
  }
}
