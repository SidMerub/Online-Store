
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:online_store/screens/product_details.dart';
import 'package:online_store/screens/subcategory_details.dart';
import 'package:online_store/screens/wishlist_screen.dart';
import 'package:online_store/widgtes/colors.dart';
import 'package:online_store/widgtes/utilities.dart';
import 'package:provider/provider.dart';
import '../firestore/firestore_services.dart';
import '../provider/category_provider.dart';
import '../provider/favourite_provider.dart';
import '../widgtes/custom_rating_bar.dart';

class CategoryDetails extends StatefulWidget {
  final String categoryText;
  const CategoryDetails({Key? key, required this.categoryText}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  Future<List<Map<String, dynamic>>> _loadProducts() async {
    String categoryName = widget.categoryText;
    return await FirestoreServices.getProductsByCategory(categoryName);
  }

  @override
  Widget build(BuildContext context) {
    String categoryName = widget.categoryText;
    List<String> subcategories = Provider.of<CategoryProvider>(context).getSubcategories(categoryName);
    //var favoriteProvider = Provider.of<FavoriteProvider>(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite,color: AppColors.pinkShade2,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteScreen()),
                );
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: subcategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubCategoryDetails(subcategoryText: subcategories[index]),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Card(
                              color: AppColors.pinkShade2,
                              child: Center(
                                child: Text(subcategories[index]),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
                    future: _loadProducts(),
                    builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error loading products'));
                      } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No items found'));
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var product = snapshot.data![index];
                              //var isFavorite = favoriteProvider.favorites.contains(product);
                              return FutureBuilder<String>(
                                future: firebase_storage.FirebaseStorage.instance
                                    .refFromURL(product['p_images'])
                                    .getDownloadURL(),
                                builder: (BuildContext context, AsyncSnapshot<String> urlSnapshot) {
                                  //if (urlSnapshot.connectionState == ConnectionState.waiting) {
                                    //return const CircularProgressIndicator();
                                  //}
                                  //if (urlSnapshot.hasError) {
                                    //return const Text('Error loading image');
                                  //}
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
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20.0), // Upper left corner straight
                                            bottomRight: Radius.circular(20.0), // Bottom right corner straight
                                          ),
                                          border: Border.all(
                                            color: AppColors.pinkShade3, // Border ka color jo dikhana hai
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
                        );
                      }
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











