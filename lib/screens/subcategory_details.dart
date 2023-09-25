import 'package:flutter/material.dart';
import 'package:online_store/screens/product_details.dart';
import 'package:online_store/widgtes/custom_rating_bar.dart';
import 'package:provider/provider.dart';

import '../firestore/firestore_services.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../provider/favourite_provider.dart';
import '../widgtes/colors.dart';
import '../widgtes/utilities.dart';

class SubCategoryDetails extends StatefulWidget {
  final String subcategoryText;
  const SubCategoryDetails({Key? key, required this.subcategoryText}) : super(key: key);

  @override
  State<SubCategoryDetails> createState() => _SubCategoryDetailsState();
}

class _SubCategoryDetailsState extends State<SubCategoryDetails> {
  Future<List<Map<String, dynamic>>>? _productsFuture;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    String subcategoryName = widget.subcategoryText;
    _productsFuture = FirestoreServices.getProductsBySubcategory(subcategoryName);
  }

  @override
  Widget build(BuildContext context) {
    String categoryName = widget.subcategoryText;

    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration:  const BoxDecoration(
                  color:AppColors.pinkShade2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _productsFuture,
                    builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(child: Text('Error loading products'));
                      }

                      List<Map<String, dynamic>> products = snapshot.data ?? [];

                      return Column(
                        children: [
                          if (products.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemCount: products.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var product = products[index];
                                  return FutureBuilder<String>(
                                    future: firebase_storage.FirebaseStorage.instance
                                        .refFromURL(product['p_images'])
                                        .getDownloadURL(),
                                    builder: (BuildContext context, AsyncSnapshot<String> urlSnapshot) {
                                      //if (urlSnapshot.connectionState == ConnectionState.waiting) {
                                        //return const CircularProgressIndicator();
                                     // }

                                      if (urlSnapshot.hasError) {
                                        return const Text('Error loading image');
                                      }

                                      if (urlSnapshot.hasData) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductDetails(
                                                  productName: product['p_name'],
                                                  productDescription: product['p_description'],
                                                  productImage: urlSnapshot.data!,
                                                  productRating: product['p_rating'],
                                                  productSubcategory: product['p_subcat'],
                                                  productPrice: product['p_price'],
                                                  productQuantity: product['p_quantity'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(20.0), // Upper left corner straight
                                                bottomRight: Radius.circular(20.0), // Bottom right corner straight
                                              ),
                                              border: Border.all(
                                            color: Colors.red, // Border ka color jo dikhana hai
                                              width: 3.0, // Border ki motai
                                            ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child: Consumer<FavoriteProvider>(
                                                      builder: (context, favoriteProvider, child) {

                                                        return IconButton(
                                                          icon: Icon(
                                                              favoriteProvider.favorites.any((item) => item['p_id'] == product['p_id'])
                                                                  ? Icons.favorite
                                                                  : Icons.favorite_border,
                                                              color: AppColors.pinkShade2
                                                          ),
                                                          onPressed: () {
                                                            if (!favoriteProvider.favorites.any((item) => item['p_id'] == product['p_id'])) {
                                                              favoriteProvider.toggleFavoriteStatus(product);
                                                              Utils().toasteMessage('Product added to your favourite list');
                                                            } else {
                                                              Utils().toasteMessage('Product already in your favourite list');
                                                            }
                                                          },
                                                        );



                                                      },
                                                    ),
                                                  ),
                                                  Image.network(
                                                    urlSnapshot.data!,
                                                    height: 50,
                                                  ),
                                                  Text(product['p_name']),
                                                  Text(product['p_price']),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20.0),
                                                    child: CustomRatingWidget(rating: product['p_rating']),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }

                                      return const Text('');
                                    },
                                  );
                                },
                              ),
                            )
                          else
                            const Center(
                              child: Text('No items found'),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






