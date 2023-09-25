import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:online_store/screens/product_details.dart';
import 'package:online_store/widgtes/colors.dart';
import 'package:online_store/widgtes/custom_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:provider/provider.dart';

import '../constant/images.dart';
import '../provider/products_provider.dart';
import 'category_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: 33,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.pinkShade2,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('CartScreen');
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          centerTitle: false,
          title: Row(
            children: [
              Text(
                'Online Shop',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: [
                  // Add your carousel items (product images) here
                  Image.asset('assets/e-image1.jpg'),
                  Image.asset('assets/e-image1.jpg'),
                  // Add more images as needed
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                ),
              ),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: TitleText('Categories'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Center(
                  child: Container(
                    height: 100, // Adjust height as per your preference
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: textList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CategoryBox(
                            textList[index],
                            imageList[index],
                                () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CategoryDetails(
                                    categoryText: textList[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, top: 2),
                child: TitleText('Popular Products'),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  if (productProvider.popularProducts.isEmpty)
                    Center(
                      child: Text('No items found'),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: productProvider.popularProducts.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var product = productProvider.popularProducts[index];
                        return FutureBuilder(
                          future: firebase_storage.FirebaseStorage.instance
                              .refFromURL(product['p_images'])
                              .getDownloadURL(),
                          builder: (BuildContext context, AsyncSnapshot<String> urlSnapshot) {
                            if (urlSnapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (urlSnapshot.hasError) {
                              return Text('Error loading image');
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
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            icon: Icon(Icons.favorite, color: Colors.red),
                                            onPressed: () {},
                                          ),
                                        ),
                                        Image.network(
                                          urlSnapshot.data!,
                                          height: 60,
                                        ),
                                        Text(product['p_name']),
                                        Text(product['p_price']),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }

                            return Text('Something went wrong');
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class CategoryBox extends StatelessWidget {
  final String categoryText;
  final String imageUrl;
  final VoidCallback onTap;

  CategoryBox(this.categoryText, this.imageUrl, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Card(
        color: AppColors.whiteShade1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: SizedBox(
          width: 70,
          height: 30,// Adjust width as per your preference
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,  // Adjust as per your preference
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Add some spacing between image and text
              Text(
                categoryText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


