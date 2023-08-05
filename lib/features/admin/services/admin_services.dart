import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone_flutter/constants/error_handling.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/models/order.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:amazon_clone_flutter/models/sales.dart';
import 'package:amazon_clone_flutter/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/globalVariables.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String descriptions,
    required double quantity,
    required String catagory,
    required double price,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('drfvz6gh4', 'crbgryws');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: descriptions,
        quantity: quantity,
        images: imageUrls,
        category: catagory,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully!');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProduct(BuildContext context) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-product'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.user.token,
      });

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void delete(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.user.token,
        },
        body: jsonEncode({"id": product.id}),
      );

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<OrderList>> fetchAllOrder(BuildContext context) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    List<OrderList> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-order'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.user.token,
      });

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              orderList
                  .add(OrderList.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void status(
      {required BuildContext context,
      required OrderList order,
      required int status,
      required VoidCallback onSuccess}) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change_orde-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.user.token,
        },
        body: jsonEncode({"id": order.id, "status": status}),
      );

      httpErrorHandling(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnning(BuildContext context) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarnign = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.user.token,
      });

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarnign = response['totalEraning'];
            sales = [
              Sales('Mobiles', response['modilesEarning']),
              Sales('essentials', response['essentialsEarning']),
              Sales('Books', response['booksarning']),
              Sales('Fashion', response['fashionEarning']),
            ];
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarnign,
    };
  }
}
