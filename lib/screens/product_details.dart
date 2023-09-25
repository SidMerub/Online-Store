import 'package:flutter/material.dart';
import 'package:online_store/screens/cartScreen.dart';
import 'package:online_store/widgtes/round_button.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../provider/cart_provider.dart';
import '../widgtes/colors.dart';
import '../widgtes/custom_rating_bar.dart';
import '../widgtes/utilities.dart';

class ProductDetails extends StatefulWidget {
  final String productName;
  final String productDescription;
  final String productImage;
  final String productRating;
  final String productSubcategory;
  final String productPrice;
  final String productQuantity;

  ProductDetails({
    required this.productName,
    required this.productDescription,
    required this.productImage,
    required this.productRating,
    required this.productSubcategory,
    required this.productPrice,
    required this.productQuantity,

  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  int cartQuantity = 0;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void addToCart() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    int existingIndex = cartProvider.CartItems.indexWhere(
          (item) => item.name == widget.productName,
    );

    if (existingIndex != -1) {
      cartProvider.updateQuantity(existingIndex, 1);
    } else {
      cartProvider.addToCart(CartItem(
        name: widget.productName,
        price: double.parse(widget.productPrice),
        quantity: 1,
        availableQuantity: int.parse(widget.productQuantity),
        image: widget.productImage,
      ));
    }



    Utils().toasteMessage('${widget.productName} added to cart');
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Quick View'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart,color: AppColors.pinkShade2,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  },
                ),
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return cartProvider.cartQuantity != 0
                        ? CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        cartProvider.cartQuantity.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                        : SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.network(
              widget.productImage,
              height: 200,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height *0.67,
            decoration:  const BoxDecoration(
              color:AppColors.pinkShade2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.productSubcategory,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.productDescription,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: CustomRatingWidget(rating: widget.productRating),
                  ),
                  Text(
                    'Price: ${widget.productPrice}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  Align(
                    alignment: Alignment.center,
                    child:MyButton(title:'Add to Cart', ontap:(){
                      addToCart();
                    })
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
