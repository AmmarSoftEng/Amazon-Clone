import 'dart:convert';
import 'package:amazon_clone_flutter/common/widgets/bootom_bar.dart';
import 'package:amazon_clone_flutter/constants/error_handling.dart';
import 'package:amazon_clone_flutter/constants/globalVariables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/auth/screen/auth_screen.dart';
import 'package:amazon_clone_flutter/models/user.dart';
import 'package:amazon_clone_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        address: '',
        password: password,
        token: '',
        types: '',
        cart: [],

      );
  
      http.Response res = await http
          .post(Uri.parse("$uri/api/signup"), body: user.toJson(), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
      });

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! login with the same credentials!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*",
          });
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await pref.setString('x-auth-token', jsonDecode(res.body)['token']);

            Navigator.pushNamedAndRemoveUntil(
                context, BootomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      // var tokenRes = await http.post(Uri.parse("$uri/tokenIsValid"), headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'x-auth-token': token!
      // });

      // var response = jsonDecode(tokenRes.body);

      // if (response == true) {
      http.Response userRes = await http.get(Uri.parse('$uri/'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      });

      var userProvider = Provider.of<UserProvider>(context, listen: false)
          .setUser(userRes.body);
      // }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    Navigator.pushReplacementNamed(context, AuthScreen.routeName);
  }
}
