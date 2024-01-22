import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:ddnangcao_project/features/auth/views/splash_screen.dart';
import 'package:ddnangcao_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
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
  void initState(){
    super.initState();
    authController.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    print("Token + ${Provider.of<UserProvider>(context).user.accessToken}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: Provider.of<UserProvider>(context).user.accessToken != ""  ? CustomerHomeScreen() : LoginScreen(),
      home: const SplashScreen(),
      //home: ForgotPasswordScreen(),
    );
  }
}
