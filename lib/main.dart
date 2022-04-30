import 'package:bachhoaxanh/providers/CartProvider.dart';
import 'package:bachhoaxanh/providers/CategoryProvider.dart';
import 'package:bachhoaxanh/providers/FavoriteProvider.dart';
import 'package:bachhoaxanh/providers/ProductProvider.dart';
import 'package:bachhoaxanh/providers/SearchProvider.dart';
import 'package:bachhoaxanh/providers/UserProvider.dart';
import 'package:bachhoaxanh/screens/address_screen.dart';
import 'package:bachhoaxanh/screens/cart_screen.dart';
import 'package:bachhoaxanh/screens/favor_screen.dart';
import 'package:bachhoaxanh/screens/home_screen.dart';
import 'package:bachhoaxanh/screens/login_screen.dart';
import 'package:bachhoaxanh/screens/order_detail_screen.dart';
import 'package:bachhoaxanh/screens/order_screen.dart';
import 'package:bachhoaxanh/screens/profile_screen.dart';
import 'package:bachhoaxanh/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          primaryColor: primaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor),
          fontFamily: 'Spartan'),
      routes: {
        loginRoute: (context) => LoginScreen(),
        registerRoute: (context) => RegisterScreen(),
        homeRoute: (context) => HomeScreen(),
        cartRoute: (context) => CartScreen(),
        favorRoute: (context) => FavorScreen(),
        orderRoute: (context) => OrderScreen(),
        orderDetailRoute: (context) => OrderDetailScreen(),
        profileRoute: (context) => ProfileScreen(),
        addressRoute: (context) => AddressScreen()
      },
      initialRoute: loginRoute,
    );
  }
}
