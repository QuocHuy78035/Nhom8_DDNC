import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../main/views/navbar_custom.dart';
import 'login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/images/auth/splash/splash.json'),
      splashIconSize: 250,
      backgroundColor: Colors.black,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      nextScreen: Provider.of<UserProvider>(context).user.accessToken != ""  ? const CustomerHomeScreen() : const LoginScreen(),
    );


    // return FutureBuilder<bool>(
    //   future: checkLoggedInUser(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     } else {
    //       if (snapshot.hasError) {
    //         return Scaffold(
    //           body: Center(
    //             child: Text('Error: ${snapshot.error}'),
    //           ),
    //         );
    //       } else {
    //         final isLoggedIn = snapshot.data!;
    //         return AnimatedSplashScreen(
    //           splash: Lottie.asset('assets/images/auth/splash/splash.json'),
    //           splashIconSize: 250,
    //           backgroundColor: Colors.black,
    //           pageTransitionType: PageTransitionType.rightToLeftWithFade,
    //           nextScreen: isLoggedIn ? CustomerHomeScreen() : LoginScreen(),
    //         );
    //       }
    //     }
    //   },
    // );
  }

  // Future<bool> checkLoggedInUser() async {
  //   final db = await DatabaseHelper.database;
  //   final result = await db.query('users');
  //   return result.isNotEmpty;
  // }
}