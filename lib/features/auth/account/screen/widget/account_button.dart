// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTab;
  AccountButton({
    Key? key,
    required this.text,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white,width: 0.0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onTab,
          child: Text(text,style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),)),
      ),
    );
  }
}
