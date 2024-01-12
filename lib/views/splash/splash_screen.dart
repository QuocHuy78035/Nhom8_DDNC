import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bt1/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/splash.json'),
      splashIconSize: 250,
      backgroundColor: Colors.black,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      nextScreen: const LoginScreen(),
    );
  }
}
