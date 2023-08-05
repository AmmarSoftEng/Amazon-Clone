// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  int maxlines;
  CustomeTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxlines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'enter your $hintText';
        }
        return null;
      },
    );
  }
}
