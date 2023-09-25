import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../models/cart_model.dart';


class CartProvider extends ChangeNotifier {
  int cartQuantity = 0;
  List<CartItem> CartItems = [];

  void addToCart(CartItem item) {
    CartItems.add(item);
    cartQuantity++;
    notifyListeners();
  }

  void updateQuantity(int index, int change) {
    final item = CartItems[index];
    final newQuantity = item.quantity + change;

    if (newQuantity >= 0 && newQuantity <= item.availableQuantity) {
      item.quantity = newQuantity;
      notifyListeners();
    }
  }

  void removeFromCart(int index) {
    CartItems.removeAt(index);
    cartQuantity--;
    notifyListeners();
  }
}


