import 'package:fast_food_cafe_grill/Provider/Cart.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Provider/Orders.dart';
import 'package:fast_food_cafe_grill/Screens/ItemDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'StartScreens/SplashScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => MenusProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Order(),
        ),
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF3F51B5),
        // primarySwatch: Color(0xFF3F51B5),
        // ignore: deprecated_member_use
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            subtitle1: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            subtitle2: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.normal,
              fontSize: 18,
            )),
      ),
      home: const SplashScreen(),
      routes: {
        ItemDetailScreen.routeName: (ctx) => const ItemDetailScreen(),
      },
    );
  }
}