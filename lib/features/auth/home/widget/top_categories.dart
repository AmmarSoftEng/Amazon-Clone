import 'package:amazon_clone_flutter/constants/globalVariables.dart';
import 'package:amazon_clone_flutter/features/auth/screen/catagory_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String catagory) {
    Navigator.pushNamed(context, CatagoryDeals.routName, arguments: catagory);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          itemExtent: 85,
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: (contex, index) {
            return GestureDetector(
              onTap: () {
                navigateToCategoryPage(
                    context, GlobalVariables.categoryImages[index]['title']!);
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
