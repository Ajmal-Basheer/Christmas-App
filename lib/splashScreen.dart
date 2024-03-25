
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:christmas/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> { // Added type for the State

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      centered: true,
      splash: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,// Added to center the image
            children: [
              SizedBox(height: 160,),
              Lottie.asset('asset/Splash.json',
                width: 150,
              )
              // Corrected the asset path
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white, // Removed MaterialStateProperty.all
      nextScreen: Happy_Christmas(),
      splashIconSize: 400,
      duration: 500,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}