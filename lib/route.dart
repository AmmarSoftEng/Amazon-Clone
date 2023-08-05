import 'package:amazon_clone_flutter/common/widgets/bootom_bar.dart';
import 'package:amazon_clone_flutter/features/address/screen/address_screen.dart';
import 'package:amazon_clone_flutter/features/admin/screen/add_product_screen.dart';
import 'package:amazon_clone_flutter/features/auth/home/screens/home_screen.dart';
import 'package:amazon_clone_flutter/features/auth/screen/auth_screen.dart';
import 'package:amazon_clone_flutter/features/auth/screen/catagory_screen.dart';
import 'package:amazon_clone_flutter/features/order_details/screen/order_details.dart';
import 'package:amazon_clone_flutter/features/product_details/screen/product_detial.dart';
import 'package:amazon_clone_flutter/features/search/screen/search_screen.dart';
import 'package:amazon_clone_flutter/models/order.dart';
import 'package:flutter/material.dart';

import 'models/product.dart';

Route<dynamic> genrateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BootomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BootomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CatagoryDeals.routName:
      var catagory = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CatagoryDeals(catagory: catagory),
      );
    case SearchScreen.routeName:
      var searchQuary = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuary: searchQuary),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as OrderList;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          orderList: order,
        ),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Text('Screen does not exsit'),
              ));
  }
}
