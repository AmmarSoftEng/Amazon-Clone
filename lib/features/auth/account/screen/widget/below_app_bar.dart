import 'package:amazon_clone_flutter/constants/globalVariables.dart';
import 'package:amazon_clone_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {

  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context).user;
    return Container(
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: RichText(
              text: TextSpan(
                text: 'Hello, ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                children: [  
                TextSpan(
                text: user.email,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),
                ),
                ]
              ),
              ),
          ),
            
        ],
      ),

    );
  }
}