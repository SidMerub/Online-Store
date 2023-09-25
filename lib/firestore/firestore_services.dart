import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class FirestoreServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<Map<String, dynamic>>> getProductsByCategory(String categoryName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('products')
          .where('p_cat', isEqualTo: categoryName)
          .get();

      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
  static Future<List<Map<String, dynamic>>> getProductsBySubcategory(String subcategoryName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('products')
          .where('p_subcat', isEqualTo: subcategoryName)
          .get();

      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}