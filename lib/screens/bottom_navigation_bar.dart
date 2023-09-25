import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_store/screens/cartScreen.dart';
import 'package:online_store/screens/home_screen.dart';
import 'package:online_store/screens/shipping_information_screen.dart';
import 'package:online_store/screens/signUp_screen.dart';
import 'package:online_store/screens/wishlist_screen.dart';
import 'package:online_store/widgtes/colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  final screens = [
    const HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    const SignUpScreen(),

  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.shopping_cart, size: 30),
      const Icon(Icons.add, size: 30),
      const Icon(Icons.favorite_rounded, size: 30),
      const Icon(Icons.local_shipping, size: 30),
    ];

    return Scaffold(
      backgroundColor: AppColors.pink,
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(
              color:AppColors.pinkShade2,
            ),
          ),
          child: CurvedNavigationBar(
            key: navigationKey,
            backgroundColor: Colors.black38,
            height: 60,
            index: index,
            items: items,
            onTap: (index) => setState(() => this.index = index),
          )),
      body: screens[index],
    );
  }
}

