import 'package:ddnangcao_project/models/user.dart';
import 'package:ddnangcao_project/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/global_variable.dart';
import 'i_auth.dart';

class AuthController implements IAuth {
  @override
  Future<String> loginUser(String email, String password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String resMessage;
    // String? accessToken = prefs.getString('accessToken');
    // print("123 ${prefs.getString('accessToken')}");

    final response = await http.post(
      Uri.parse('${GlobalVariable.apiUrl}/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': accessToken ?? ""
      },
      body: jsonEncode(
        {'email': email, 'password': password},
      ),
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    if (response.statusCode == 200) {
      String accessToken = data['metadata']['tokens']['accessToken'].toString();
      String refreshToken =
      data['metadata']['tokens']['refreshToken'].toString();
      String userId = data['metadata']['user']['_id'].toString();
      String name = data['metadata']['user']['name'].toString();
      String email = data['metadata']['user']['email'].toString();
      await prefs.setString('accessToken', accessToken);
      await prefs.setString("refreshToken", refreshToken);
      await prefs.setString("userId", userId);
      await prefs.setString("name", name);
      await prefs.setString("email", email);
      Provider.of<UserProvider>(context, listen: false)
          .setUser(data['metadata']['user']);
    } else {
      return resMessage;
      //throw Exception('Failed to log in');
    }
    return resMessage;
  }

  @override
  Future<String> registerUser(String name, String email, String password,
      String passwordConfirm, BuildContext context) async {
    late String resMessage;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${GlobalVariable.apiUrl}/signup'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "name": name,
          "email": email,
          "password": password,
          "passwordConfirm": passwordConfirm
        },
      ),
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    if (response.statusCode == 201) {
      String accessToken = data['metadata']['tokens']['accessToken'].toString();
      String refreshToken =
          data['metadata']['tokens']['refreshToken'].toString();
      String userId = data['metadata']['user']['_id'].toString();
      String name = data['metadata']['user']['name'].toString();
      String email = data['metadata']['user']['email'].toString();
      await prefs.setString('accessToken', accessToken);
      await prefs.setString("refreshToken", refreshToken);
      await prefs.setString("userId", userId);
      await prefs.setString("name", name);
      await prefs.setString("email", email);
      Provider.of<UserProvider>(context, listen: false)
          .setUser(data['metadata']['user']);
    } else {
      return resMessage;
      //throw Exception('Failed to log in');
    }
    return resMessage;
  }

  Future<void> getUserData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    String userId = prefs.getString("userId") ?? "";
    print("userId controller $userId");
    String email = prefs.getString("email") ?? "";
    String name = prefs.getString("name") ?? "";
    String accessToken = prefs.getString("accessToken") ?? "";
    String refreshToken = prefs.getString("refreshToken") ?? "";
    User user = User(
        id: userId,
        name: name,
        email: email,
        accessToken: accessToken,
        refreshToken: refreshToken);
    userProvider.setUserFromModel(user);
  }
}
