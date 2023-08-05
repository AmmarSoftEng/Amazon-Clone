// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone_flutter/constants/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  Stars({
    Key? key,
    required this.rating,
  }) : super(key: key);
  final double rating;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      rating: rating,
      itemSize: 15,
      itemBuilder: (context, _) {
        return Icon(
          Icons.star,
          color: GlobalVariables.secondaryColor,
        );
      },
    );
  }
}
