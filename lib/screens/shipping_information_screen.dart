import 'package:flutter/material.dart';
import 'package:online_store/widgtes/custom_text.dart';
import '../models/cart_model.dart';
import '../widgtes/colors.dart';
import '../widgtes/custom_textformfeild.dart';
import '../widgtes/round_button.dart';
import '../widgtes/shapes.dart';
import 'payment_method_screen.dart'; // Import the PaymentMethodScreen file

class ShippingInformationScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double total;

  const ShippingInformationScreen({super.key,required this.cartItems,
    required this.total,});

  @override
  State<ShippingInformationScreen> createState() => _ShippingInformationScreenState();
}

class _ShippingInformationScreenState extends State<ShippingInformationScreen> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();

  void _showPaymentMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.pinkShade2,
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Cash on Delivery'),
                onTap: () {
                  // User selected Cash on Delivery
                  // Redirect to Payment Method Screen
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderConfirmationScreen(
                        cartItems: widget.cartItems,
                        total: widget.total,
                        name: _nameController.text,
                        mobileNumber: _mobileController.text,
                        address: _addressController.text,
                        city: _cityController.text,
                        paymentMethod: 'Cash on Delivery',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('Stripe Payment'),
                onTap: () {
                  // User selected Stripe Payment
                  // Redirect to Payment Method Screen
                  //Navigator.pop(context);
                  //Navigator.push(
                    //context,
                   // MaterialPageRoute(builder: (context) => PaymentMethodScreen(method: 'Stripe')),
                 // );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: ClipContainer(),
              child:Container(
                width:MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height* 0.4,
                decoration: const BoxDecoration(
                    color: AppColors.pinkShade2
                  //   borderRadius: BorderRadius.only(
                  //bottomLeft: Radius.circular(30),
                  //bottomRight: Radius.circular(40),
                  //  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Align(
                alignment: Alignment.center,
                child: TitleText('Shipping Information')
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 120.0, 40, 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 231, 230, 230).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,),
                            child: CustomTextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              hintText: 'Enter Your Name',
                              labelText: 'Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your Name';
                                }
                                return null;
                              },
                              prefixIcon: const Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: _mobileController,
                              keyboardType: TextInputType.phone,
                              hintText: 'Enter Your Mobile Number',
                              labelText: 'Mobile Number',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your Mobile Number';
                                }
                                return null;
                              },
                              prefixIcon: const Icon(Icons.phone),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: _addressController,
                              keyboardType: TextInputType.text,
                              hintText: 'Enter Your Address',
                              labelText: 'Address',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your Address';
                                }
                                return null;
                              },
                              prefixIcon: const Icon(Icons.home),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: _cityController,
                              keyboardType: TextInputType.text,
                              hintText: 'Enter Your City',
                              labelText: 'City',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your City';
                                }
                                return null;
                              },
                              prefixIcon: const Icon(Icons.location_city),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    RoundButton(
                      ontap: () {
                        if (_formkey.currentState!.validate()) {
                          _showPaymentMethodBottomSheet(context);
                        }
                      },
                      title: 'Proceed to Payment',
                    ),
                  ],
                ),
              ),
            ),

          ]

        ),
      ),
    );
  }
}
