import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _popularProducts = [];

  List<Map<String, dynamic>> get popularProducts => _popularProducts;

  Future<void> fetchPopularProducts() async {
    print('Fetching popular products...');
    try {

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('p_type', isEqualTo: 'Popular')
          .get();
      List<DocumentSnapshot> documents = snapshot.docs;
      List<Map<String, dynamic>> fetchedProducts = documents
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
      _popularProducts = fetchedProducts;
      notifyListeners();
    } catch (e) {

    }
  }
}
