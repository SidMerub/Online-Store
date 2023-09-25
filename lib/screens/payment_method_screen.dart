import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../widgtes/colors.dart';
import '../widgtes/round_button.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final List<CartItem> cartItems;
  final double total;
  final String name;
  final String mobileNumber;
  final String address;
  final String city;
  final String paymentMethod;

  const OrderConfirmationScreen({
    required this.cartItems,
    required this.total,
    required this.name,
    required this.mobileNumber,
    required this.address,
    required this.city,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100.0,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Container(
              width:MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.pinkShade3,
                  width: 3.0,
                ),
              ),
              child: Column(children: [
                Text('Name: $name'),
                Text('Mobile Number: $mobileNumber'),
                Text('Address: $address, $city'),
              ],),
            ),
            //Text('Name: $name'),
            //Text('Mobile Number: $mobileNumber'),
            //Text('Address: $address, $city'),
            const SizedBox(height: 16.0),
            const Text(
              'Ordered Items:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width:MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.pinkShade3,
                  width: 3.0,
                ),
              ),
              child: Column(
                children: cartItems.map((item) {
                  return ListTile(
                    leading: Image.network(item.image),
                    title: Text(item.name),
                    //title: Text(item.name),
                    //trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16.0),
            Text('Total Balance:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text('${total.toStringAsFixed(2)}'),
            const SizedBox(height: 16.0),
            Text(
              'Payment Method: $paymentMethod',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: RoundButton(
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Thank You!'),
                        content: const Text('Your order has been confirmed. Thank you for shopping with us!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              // Perform any additional actions after confirmation here
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                title:'Confirm Order',
              )

            ),
          ],
        ),
      ),
    );
  }
}
