import 'package:amazon_clone_flutter/features/auth/account/screen/widget/account_button.dart';
import 'package:flutter/material.dart';

class TopButton extends StatefulWidget {
  const TopButton({Key? key}) : super(key: key);

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Yours Orde', onTab: (){}),
            AccountButton(text: 'Turn to Seller', onTab: (){}),
          ],  
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(text: 'Log Out', onTab: (){}),
            AccountButton(text: 'Your Wish List', onTab: (){}),
          ],
          ),
      ],
    );
  }
}