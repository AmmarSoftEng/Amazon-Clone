// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  String image;
  SingleProduct({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: 200,
          padding: EdgeInsets.all(10),
          child: Image.network(
            image,
            fit: BoxFit.contain,
            width: 200,
          ),
        ),
      ),
    );
  }
}
