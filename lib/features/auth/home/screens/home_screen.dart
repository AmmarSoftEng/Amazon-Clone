import 'package:amazon_clone_flutter/features/auth/home/widget/addres_box.dart';
import 'package:amazon_clone_flutter/features/auth/home/widget/carousel_image.dart';
import 'package:amazon_clone_flutter/features/auth/home/widget/deal_of_day.dart';
import 'package:amazon_clone_flutter/features/auth/home/widget/top_categories.dart';
import 'package:amazon_clone_flutter/features/search/screen/search_screen.dart';
import 'package:amazon_clone_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/globalVariables.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigationToShearch(String qurey) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: qurey);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(17),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigationToShearch,
                      decoration: InputDecoration(
                        prefix: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        hintText: 'Search Amazon',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                        // prefixIcon: Icon(Icons.search,color: Colors.black,size: 22,),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.transparent,
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 23,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            SizedBox(
              height: 10,
            ),
            TopCategories(),
            SizedBox(
              height: 10,
            ),
            CarouselImage(),
            DealOfDay(),
          ],
        ),
      ),
    );
  }
}
