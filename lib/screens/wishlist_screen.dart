import 'package:flutter/material.dart';
import 'package:online_store/widgtes/colors.dart';
import 'package:online_store/widgtes/utilities.dart';
import 'package:provider/provider.dart';
import '../provider/favourite_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../widgtes/custom_rating_bar.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoriteProvider>(context);
    List<Map<String, dynamic>> favoriteProducts = favoriteProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Items'),
      ),
      body: Container(
        decoration:  const BoxDecoration(
          color:AppColors.pinkShade2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: favoriteProducts.length,
            itemBuilder: (BuildContext context, int index) {
              var product = favoriteProducts[index];
              return Container(
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
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: AppColors.pinkShade2,
                        ),
                        onPressed: () {
                          favoriteProvider.removeFromFavorites(product);
                          Utils().toasteMessage('Items removed from wishlist');
                        },
                      ),
                    ),
                    FutureBuilder<String?>(
                      future: firebase_storage.FirebaseStorage.instance
                          .refFromURL(product['p_images'])
                          .getDownloadURL(),
                      builder: (BuildContext context, AsyncSnapshot<String?> urlSnapshot) {
                        if (urlSnapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        if (urlSnapshot.hasError) {
                          return const Text('Error loading image');
                        }

                        if (urlSnapshot.hasData) {
                          return Image.network(
                            urlSnapshot.data!,
                            height: 50,
                          );
                        }

                        return const Text('Something went wrong');
                      },
                    ),
                    Text(product['p_name']),
                    Text(product['p_price']),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: CustomRatingWidget(rating: product['p_rating']),
                    ),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
