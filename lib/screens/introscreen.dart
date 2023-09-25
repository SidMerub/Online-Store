import 'package:flutter/material.dart';
import 'package:online_store/screens/login_screen.dart';
import 'package:online_store/screens/signUp_screen.dart';
import 'package:online_store/widgtes/colors.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/e-image1.jpg'), // Replace with your image path

                  ),
                ),

              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration:  const BoxDecoration(
                  color:AppColors.pinkShade2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color:AppColors.black
                      ),
                    ),
                     SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    const Text(
                      'Discover the perfect bag that complements your attire and suits every occasion – from sophisticated clutches to spacious backpacks, we have something for everyone. Elevate your charm further with our handpicked beauty products, carefully curated to enhance your natural glow. ',
                      style: TextStyle(
                        fontSize: 16,
                        color:AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                     SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text('Login'),
                        ),
                         SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpScreen()),
                            );

                          },
                          child: const Text('Signup'),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
