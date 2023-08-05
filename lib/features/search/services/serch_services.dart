import 'dart:convert';
import 'package:provider/provider.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/globalVariables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../provider/user_provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchProduct(
      {required BuildContext context, required String searchQurey}) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$searchQurey'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.user.token,
      });
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
