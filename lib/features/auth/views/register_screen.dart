
import 'package:ddnangcao_project/widgets/base_button.dart';
import 'package:ddnangcao_project/widgets/base_input.dart';
import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:ddnangcao_project/utils/validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../widgets/facebook_button.dart';
import '../widgets/google_button.dart';
import '../widgets/text_navigator.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  final AuthController authController = AuthController();
  late String name;
  late String email;
  late String password;
  late String passwordConfirm;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showSnackBar(String message, Color? colorBackground, Color? colorText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: colorBackground ?? ColorLib.primaryColor,
        content: Text(
          message,
          style: TextStyle(
            fontSize: 18,
            color: colorText ?? ColorLib.blackColor,
          ),
        ),
      ),
    );
  }

  registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String message = await authController.registerUser(
          name, email, password, passwordConfirm, context);
      setState(() {
        isLoading = false;
      });
      if (message == "Sign up successfully!") {
        showSnackBar(message, Colors.green, Colors.black);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        showSnackBar(message, ColorLib.primaryColor, Colors.white);
      }
      print('success');
    } else {
      showSnackBar(
          "Please fill all fields", ColorLib.primaryColor, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Distance(
                    height: GetSize.distance * 2,
                  ),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  BaseInput(
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your full name";
                      }
                      return null;
                    },
                    type: "Full name",
                    hintText: "Full name",
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  BaseInput(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (value.isVailEmail() == false) {
                        return "Invalid email";
                      }
                      return null;
                    },
                    type: "Email",
                    hintText: "Your email",
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  BaseInput(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    type: "Password",
                    hintText: "Your password",
                    isPass: true,
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  BaseInput(
                    onChanged: (value) {
                      passwordConfirm = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password confirm";
                      }
                      return null;
                    },
                    type: "Password confirm",
                    hintText: "Your password confirm",
                    isPass: true,
                  ),
                  const Distance(
                    height: GetSize.distance * 4,
                  ),
                  SizedBox(
                    height: GetSize.getHeight(context) * 0.06,
                    width: GetSize.getWidth(context),
                    child: BaseButton(
                      onPressed: () async {
                        registerUser();
                      },
                      titleRow: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 20,
                                color: ColorLib.whiteColor,
                              ),
                            ),
                    ),
                  ),
                  const Distance(
                    height: GetSize.distance,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextNavigator(
                        title: "Sign In",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  const Distance(
                    height: GetSize.distance * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Line(
                        width: GetSize.getWidth(context) * 0.2,
                      ),
                      const Distance(
                        width: GetSize.distance,
                      ),
                      const Text("Or Sign up with"),
                      const Distance(
                        width: GetSize.distance,
                      ),
                      Line(
                        width: GetSize.getWidth(context) * 0.2,
                      ),
                    ],
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  FaceBookButton(onPressed: () {}),
                  const Distance(
                    height: GetSize.distance,
                  ),
                  GoogleButton(onPressed: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  final double width;

  const Line({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: width,
      color: ColorLib.blackColor,
    );
  }
}

class Distance extends StatelessWidget {
  final double? height;
  final double? width;

  const Distance({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }
}
