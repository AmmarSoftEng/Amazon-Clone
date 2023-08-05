import 'dart:convert';

import 'package:amazon_clone_flutter/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/error_handling.dart';
import '../../../../constants/globalVariables.dart';
import '../../../../constants/utils.dart';
import '../../../../provider/user_provider.dart';

class AccountServices {
  Future<List<OrderList>> fetchOrders({required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    List<OrderList> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.user.token,
      });
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList.add(
                OrderList.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }
}
