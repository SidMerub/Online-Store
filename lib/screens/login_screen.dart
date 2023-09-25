import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_store/screens/bottom_navigation_bar.dart';
import 'package:online_store/screens/fogot_password.dart';
import 'package:online_store/screens/home_screen.dart';

import '../widgtes/colors.dart';
import '../widgtes/custom_textformfeild.dart';
import '../widgtes/round_button.dart';
import '../widgtes/shapes.dart';
import '../widgtes/utilities.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading=false;
  final _formkey= GlobalKey<FormState>();
  final TextEditingController _emailcontroller= TextEditingController();
  final TextEditingController _passwordcontroller= TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  bool _isPasswordVisible = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

  }
  void login(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(email: _emailcontroller.text.toString(),
        password: _passwordcontroller.text.toString()).then((value) {

      Utils().toasteMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder:(context)=> BottomBar()));
      setState(() {
        loading=false;
      });
    }).onError((error, stackTrace) {

      debugPrint(error.toString());
      Utils().toasteMessage(error.toString());
      setState(() {
        loading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(

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
                        backgroundImage: AssetImage('assets/login.jpg'),
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
                                    child: CustomTextFormField(controller: _emailcontroller,
                                        keyboardType: TextInputType.text,
                                        hintText: 'Enter Your Email',
                                        labelText:'Email',
                                        validator: (value){
                                          if(value!.isEmpty){
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
                                    controller: _passwordcontroller,
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


                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          RoundButton(
                            title: 'Sign In',
                            loading: loading,
                            ontap: () {
                              if (_formkey.currentState!.validate()) {
                                login();
                              }
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(onPressed:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                            }, child: Text('Forgot Password?')),
                          )


                        ],
                      ),
                    ),
                  )
                ]
            ),
          )
      )
    );
  }
}
