import 'package:flutter/material.dart';
import 'package:online_store/screens/shipping_information_screen.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../provider/cart_provider.dart';
import '../widgtes/colors.dart';
import '../widgtes/round_button.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double deliveryCharge = 200.0; // Assuming a static delivery charge of 200
  double discountPercent = 15;
  double discountAmount = 0.0;
  double subtotal = 0.0;
  TextEditingController discountController = TextEditingController();
  String discountCode = "";

  double calculateSubtotal(List<CartItem> cartItems) {
    double subtotal = 0.0;
    for (final cartItem in cartItems) {
      subtotal += cartItem.quantity * cartItem.price;
    }
    return subtotal;
  }

  double calculateTotal(List<CartItem> cartItems) {
    double subtotal = calculateSubtotal(cartItems);
    double total = subtotal + deliveryCharge - discountAmount;
    return total;
  }

  void applyDiscount(String code) {
    // Check if the entered code is valid
    if (code == 'SK10') {
      discountAmount = (subtotal * discountPercent) / 100;
    } else {
      discountAmount = 0.0;
    }
    setState(() {});
  }

  void clearDiscountCode() {
    setState(() {
      discountController.clear();
      discountCode = "";
      discountAmount = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.CartItems;
    subtotal = calculateSubtotal(cartItems);
    double total = calculateTotal(cartItems);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.pinkShade3,
                      width: 3.0,
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(cartItem.image),
                    title: Text(cartItem.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: AppColors.pinkShade2),
                              onPressed: () {
                                if (cartItem.quantity > 1) {
                                  cartProvider.updateQuantity(index, -1);
                                }
                              },
                            ),
                            Text('${cartItem.quantity}'),
                            IconButton(
                              icon: Icon(Icons.add, color: AppColors.pinkShade2),
                              onPressed: () {
                                if (cartItem.quantity < cartItem.availableQuantity) {
                                  cartProvider.updateQuantity(index, 1);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: AppColors.pinkShade2),
                      onPressed: () {
                        setState(() {
                          cartProvider.removeFromCart(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: AppColors.pinkShade2,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal'),
                    Text('\$${subtotal.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charge'),
                    Text('\$${deliveryCharge.toStringAsFixed(2)}'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '-\$${discountAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                DiscountInput(
                  controller: discountController,
                  onClear: clearDiscountCode,
                  onChanged: applyDiscount,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: RoundButton(
              ontap: () {
                // Collect necessary data
                double total = calculateTotal(cartItems);

                // Navigate to ShippingInformationScreen and pass data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShippingInformationScreen(
                      cartItems: cartItems,
                      total: total,
                    ),
                  ),
                );
              },
              title: 'Proceed to Checkout',
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onClear;
  final Function(String) onChanged;

  const DiscountInput({
    Key? key,
    required this.controller,
    required this.onClear,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DiscountInputState createState() => _DiscountInputState();
}

class _DiscountInputState extends State<DiscountInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextFormField(
                controller: widget.controller,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  labelText: 'Discount Code',
                  border: OutlineInputBorder(),
                ),
              ),
              if (widget.controller.text.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    widget.onClear();
                    setState(() {
                      widget.controller.clear();
                    });
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
