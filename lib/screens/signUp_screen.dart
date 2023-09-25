import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_store/widgtes/colors.dart';
import 'package:online_store/widgtes/custom_textformfeild.dart';

import '../widgtes/round_button.dart';
import '../widgtes/shapes.dart';
import '../widgtes/utilities.dart';




class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
  }

  void signup() {
    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
      email: _emailController.text.toString(),
      password: _passwordController.text.toString(),
    )
        .then((value) {
      // Additional user information like name and phone number can be stored in the user's Firestore document or any other storage solution.
      // Here, we are just showing a toast message after successful registration.
      Utils().toasteMessage("You're registered successfully");
      setState(() {
        loading = false;
      });
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      Utils().toasteMessage(error.toString());
    });
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
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 75, // Avatar ka radius, jisse aap size control kar sakte hain
                    backgroundImage: AssetImage('assets/register-here.PNG'),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(40, 250.0, 40, 20),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      const SizedBox(height: 30),
                      Form(
                        key: _formkey,
                        child: Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20,),
                              child: CustomTextFormField(controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  hintText: 'Enter Your Name',
                                  labelText:'Name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your Name';
                                    }
                                    return null;
                                  },
                                  prefixIcon:const Icon(Icons.person))
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomTextFormField(controller:_emailController,
                                  keyboardType: TextInputType.text,
                                  hintText:'Enter your Email',
                                  labelText: 'Email',
                                  validator: (value) {
                                      if (value!.isEmpty) {
                                      return 'Enter Email';
                                         } else if (!value.contains('@')) {
                                         return 'Enter a valid email';
                                             }
                                           return null;
                                             },
                                  prefixIcon:const Icon(Icons.email))
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomTextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.text,
                                obscureText:!_isPasswordVisible,

                                  prefixIcon: const Icon(Icons.key),
                                  suffixIcon:  IconButton(
                                    icon: Icon(_isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                  hintText: 'Enter Your Password',
                                  labelText: 'Password',

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomTextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: !_isPasswordVisible,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                  hintText: 'Confirm Password',
                                  labelText: 'Confirm Password',

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Confirm your password';
                                  } else if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      RoundButton(
                        title: 'SignUp',
                        loading: loading,
                        ontap: () {
                          if (_formkey.currentState!.validate()) {
                            signup();
                          }
                        },
                      ),

                    ],
                  ),
                ),
              )
            ]
    ),
        ));



  }
}

