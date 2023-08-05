import 'package:amazon_clone_flutter/common/widgets/bootom_bar.dart';
import 'package:amazon_clone_flutter/constants/globalVariables.dart';
import 'package:amazon_clone_flutter/features/admin/screen/admin_screen.dart';
import 'package:amazon_clone_flutter/features/auth/screen/auth_screen.dart';
import 'package:amazon_clone_flutter/features/auth/services/auth_service.dart';
import 'package:amazon_clone_flutter/provider/user_provider.dart';
import 'package:amazon_clone_flutter/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  // This widget is the root of your application.x
  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
            elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
      ),
      onGenerateRoute: (setting) => genrateRoute(setting),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.types == "user"
              ? BootomBar()
              : AdminScreen()
          : AuthScreen(),
    );
  }
}
