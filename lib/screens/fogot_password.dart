import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgtes/colors.dart';
import '../widgtes/custom_textformfeild.dart';
import '../widgtes/round_button.dart';
import '../widgtes/utilities.dart';




class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formkey= GlobalKey<FormState>();
  final TextEditingController _emailcontroller= TextEditingController();

  final emailController =TextEditingController();
  final auth = FirebaseAuth.instance ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
            width:MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height* 0.2,
            decoration: const BoxDecoration(
                color: AppColors.pinkShade2,
              borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(40),
               )
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 300,
                child: Image.asset('assets/new-password.PNG') ,

              ),
            ),
          ),

          Padding(
          padding: const EdgeInsets.only(left: 20,right:20,top:200),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(40, 200.0, 40, 20),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

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



                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      Categories(title: 'Reset Password', ontap: (){
                        auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                          Utils().toasteMessage('We have sent you email to recover password, please check email');
                        }).onError((error, stackTrace){
                          Utils().toasteMessage(error.toString());
                        });
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]
      ),
    );
  }
}
