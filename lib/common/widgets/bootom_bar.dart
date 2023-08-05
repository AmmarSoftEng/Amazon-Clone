import 'package:amazon_clone_flutter/constants/globalVariables.dart';
import 'package:amazon_clone_flutter/features/auth/account/screen/account_screen.dart';
import 'package:amazon_clone_flutter/features/auth/home/screens/home_screen.dart';
import 'package:amazon_clone_flutter/features/cart/screen/cart_screen.dart';
import 'package:amazon_clone_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootomBar extends StatefulWidget {
  static const String routeName = '/actual-home';

  const BootomBar({Key? key}) : super(key: key);

  @override
  State<BootomBar> createState() => _BootomBarState();
}

class _BootomBarState extends State<BootomBar> {
  int _page = 0;
  double bottomBarWidth = 42.0;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    AccountScreen(),
    const CartScreen(),
  ];

// void update(int page){
//   setState(() {
//     _page=page;
//   });
// }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: (val) {
          setState(() {
            _page = val;
          });
        },
        items: [
          //HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: _page == 0
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                ),
              )),
              child: Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          // PERSON
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: _page == 1
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                ),
              )),
              child: Icon(Icons.person_outlined),
            ),
            label: '',
          ),
          //CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: _page == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                ),
              )),
              // child: Badge(
              //   elevation: 0,
              //   badgeColor: Colors.white,
              //   badgeContent: Text(userCartLen.toString()),
              //   child: Icon(Icons.shopping_cart),
              // ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
