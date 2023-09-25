import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:online_store/provider/category_provider.dart';
import 'package:online_store/provider/favourite_provider.dart';
import 'package:online_store/provider/products_provider.dart';
import 'package:online_store/screens/bottom_navigation_bar.dart';
import 'package:online_store/screens/introscreen.dart';
import 'package:online_store/widgtes/colors.dart';
import 'package:provider/provider.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),

      ],

      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.pinkShade2),
        useMaterial3: true,
      ),
      home:const IntroScreen(),
    );
  }
}

