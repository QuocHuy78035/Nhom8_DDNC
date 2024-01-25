import 'package:ddnangcao_project/features/auth/views/login_screen.dart';
import 'package:ddnangcao_project/features/favourite/views/favourite_screen.dart';
import 'package:ddnangcao_project/features/profile/controllers/profile_controller.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/color_lib.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = ProfileController();

  logoutUser() async {
    String message = await profileController.logoutUser();
    profileController.logOut(context);
    debugPrint(message);
  }

  @override
  Widget build(BuildContext context) {
    final String? userName = Provider.of<UserProvider>(context).user.name;
    final String? email = Provider.of<UserProvider>(context).user.email;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 80,
                    backgroundColor: ColorLib.primaryColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    userName ?? "",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email ?? "",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const NavFunction(
              icon: Icons.person,
              title: "My Profile",
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavouriteScreen(),
                  ),
                );
              },
              child: const NavFunction(
                icon: Icons.favorite,
                title: "My Favourites",
              ),
            ),
            const NavFunction(
              icon: Icons.location_on,
              title: "Delivery Address",
            ),
            const NavFunction(
              icon: Icons.payment,
              title: "Payment Methods",
            ),
            const NavFunction(
              icon: Icons.contact_mail,
              title: "Contact Us",
            ),
            const NavFunction(
              icon: Icons.settings,
              title: "Settings",
            ),
            const NavFunction(
              icon: Icons.help,
              title: "Help & FAQ",
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              width: GetSize.getWidth(context),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorLib.primaryColor)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: ColorLib.whiteColor),
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text("Log Out"),
                      content: const Text("Are you sure to Log out?"),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: const Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text("Yes"),
                          onPressed: () async {
                            logoutUser();
                            Navigator.pop(context);
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
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: ColorLib.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Log Out",
                      style:
                          TextStyle(color: ColorLib.primaryColor, fontSize: 20),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NavFunction extends StatelessWidget {
  final String title;
  final IconData icon;

  const NavFunction({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: GetSize.symmetricPadding * 2,
          vertical: GetSize.symmetricPadding * 1.5),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: ColorLib.primaryColor,
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
          // Container(
          //   width: GetSize.getWidth(context),
          //   color: ColorLib.greyColor,
          //   height: 1,
          // )
        ],
      ),
    );
  }
}
