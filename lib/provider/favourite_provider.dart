import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;
  void toggleFavoriteStatus(Map<String, dynamic> product) {
    if (_favorites.contains(product)) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }
    notifyListeners(); // Notify the listeners after updating the list
  }
  void addToFavorites(Map<String, dynamic> product) {
    _favorites.add(product);
    notifyListeners();
  }

  void removeFromFavorites(Map<String, dynamic> product) {
    _favorites.remove(product);
    notifyListeners();
  }
}
