import 'package:animate_do/animate_do.dart';
import 'package:bt1/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          //reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/auth/background.png'),
                      fit: BoxFit.fill),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeInDown(
                        duration: const Duration(seconds: 1),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/auth/light-1.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: 140,
                    //   width: 80,
                    //   height: 150,
                    //   child: FadeInUp(
                    //     duration: const Duration(milliseconds: 1200),
                    //     child: Container(
                    //       decoration: const BoxDecoration(
                    //         image: DecorationImage(
                    //           image: AssetImage('assets/images/auth/light-2.png'),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   right: 40,
                    //   top: 40,
                    //   width: 80,
                    //   height: 150,
                    //   child: FadeInUp(
                    //     duration: const Duration(milliseconds: 1300),
                    //     child: Container(
                    //       decoration: const BoxDecoration(
                    //         image: DecorationImage(
                    //           image: AssetImage('assets/images/auth/clock.png'),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      child: FadeInDownBig(
                        duration: const Duration(milliseconds: 1600),
                        child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              const CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                    "assets/images/auth/default_avt.png"),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 10,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.camera_alt),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Hello, Welcome to Nhom8\'shop",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(143, 148, 251, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              hintText: "Enter your full name",
                              labelText: "Full name",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              labelText: "Email",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              labelText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          // TextFormField(
                          //   onChanged: (value) {},
                          //   decoration: InputDecoration(
                          //     hintText: "Enter your repeat password",
                          //     labelText: "Repeat password",
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(143, 148, 251, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 2000),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Have an account?",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(143, 148, 251, 1),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(143, 148, 251, 1),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
