// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final String text;
  VoidCallback onTab;
  final Color? color;

  CustomeButton({
    Key? key,
    required this.text,
    required this.onTab,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          minimumSize: Size(double.infinity, 50),
        ),
        onPressed: onTab,
        child: Text(
          text,
          style: TextStyle(color: color == null ? Colors.white : Colors.black),
        ));
  }
}
