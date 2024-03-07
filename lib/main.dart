import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:ddnangcao_project/features/auth/views/splash_screen.dart';
import 'package:ddnangcao_project/firebase_options.dart';
import 'package:ddnangcao_project/providers/add_to_cart_provider.dart';
import 'package:ddnangcao_project/providers/favourite_provider.dart';
import 'package:ddnangcao_project/providers/food_provider.dart';
import 'package:ddnangcao_project/providers/home_provider.dart';
import 'package:ddnangcao_project/providers/restaurant_provider.dart';
import 'package:ddnangcao_project/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddToCartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FoodProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthController authController = AuthController();


  @override
  void initState() {
    super.initState();
    authController.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: Provider.of<UserProvider>(context).user.accessToken != ""  ? CustomerHomeScreen() : LoginScreen(),
      home: const SplashScreen(),
    );
  }
}
