
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:online_store/screens/introscreen.dart';
import 'package:online_store/widgtes/colors.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: Container(
              padding: const EdgeInsets.all(8.0),
              color: AppColors.googleRed, // set background color
              child: const Text("Welcome to Online Store",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white),
                      )
          ),
          body: "Your one-stop destination for all your shopping needs. Explore a wide range of products and discover exciting deals!",
          image: const CustomContainer(imageAsset: "assets/e-image1.jpg"),


        ),
        PageViewModel(
          titleWidget: Container(
              padding: const EdgeInsets.all(8.0),
              color:  AppColors.googleRed, // set background color
              child: const Text("Explore, Checkout, and Chat",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white),
              )
          ),
          body: "Browse through our extensive collection, add items to your cart, and connect with sellers in real-time. Shop smartly with us!",
          image: const CustomContainer(imageAsset: "assets/e-image1.jpg"),
        ),
        PageViewModel(
          titleWidget: Container(
              padding: const EdgeInsets.all(8.0),
              color:  AppColors.googleRed, // set background color
              child: const Text("Start Your Shopping Journey",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white),
              )
          ),

          body: "Create an account, personalize your profile, and start shopping with ease. Join our community and enhance your shopping experience.",
          image:  const CustomContainer(imageAsset: "assets/e-image1.jpg"),
        ),
      ],
      onDone: () {
        // Navigate to main app screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const IntroScreen()),
        );
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Start"),
    );
  }
}
class CustomContainer extends StatelessWidget {

  final String imageAsset;

  const CustomContainer({super.key,
    
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imageAsset),
        ),
      ),
    );
  }
}
