import 'package:flutter/material.dart';
import 'package:kthp_moblie/provider/buyer_provider.dart';
import 'package:kthp_moblie/provider/cart_provider.dart';
import 'package:kthp_moblie/provider/home_provider.dart';
import 'package:kthp_moblie/provider/login_provider.dart';
import 'package:kthp_moblie/screens/login/sign_in.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => BuyerProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
