import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> _categories = [];

  List<Map<String, dynamic>> get categories => _categories;

  CategoryProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      String data = await rootBundle.loadString('lib/services/category_model.json');
      List<dynamic> jsonData = json.decode(data)['categories'];
      _categories = List<Map<String, dynamic>>.from(jsonData);
      notifyListeners();
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  List<String> getSubcategories(String categoryName) {
    for (var category in _categories) {
      if (category['name'] == categoryName) {
        List<dynamic> subcategories = category['subcategories'];
        return List<String>.from(subcategories);
      }
    }
    return [];
  }
}
