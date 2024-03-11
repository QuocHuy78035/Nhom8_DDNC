import 'dart:convert';
import 'package:ddnangcao_project/api_service.dart';
import 'package:ddnangcao_project/features/auth/views/login_screen.dart';
import 'package:ddnangcao_project/features/profile/controllers/i_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController implements IProfile {

  Future<String> logoutUser() async {
    final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
    late String resMessage;
    final response = await apiServiceImpl.post(url: "logout", params: {});
    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    return resMessage;
  }

  @override
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('accessToken', '');
      await sharedPreferences.setString("userId", "");
      await sharedPreferences.setString("email", "");
      await sharedPreferences.setString("name", "");
      await sharedPreferences.setString("refreshToken", "");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
