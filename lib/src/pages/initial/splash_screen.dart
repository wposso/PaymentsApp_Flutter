import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/pages/initial/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset('assets/splash.json'),
          ),
        ],
      ),
      nextScreen: const LoginPage(),
      splashIconSize: 450,
      backgroundColor: colorPrimario,
    );
  }
}
