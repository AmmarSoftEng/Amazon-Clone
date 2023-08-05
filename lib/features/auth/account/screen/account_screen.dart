import 'package:amazon_clone_flutter/constants/globalVariables.dart';
import 'package:amazon_clone_flutter/features/auth/account/screen/widget/below_app_bar.dart';
import 'package:amazon_clone_flutter/features/auth/account/screen/widget/order.dart';
import 'package:amazon_clone_flutter/features/auth/account/screen/widget/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  'AMAZON',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notification_add_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(height: 10),
          TopButton(),
          SizedBox(height: 20),
          Orders(),
        ],
      ),
    );
  }
}
