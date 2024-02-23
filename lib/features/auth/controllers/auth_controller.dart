import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddnangcao_project/models/user.dart';
import 'package:ddnangcao_project/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/global_variable.dart';
import 'i_auth.dart';

class AuthController implements IAuth {
  static String resetUrl = "";

  @override
  Future<String> loginUser(String email, String password,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String resMessage;
    final response = await http.post(
      Uri.parse('${GlobalVariable.apiUrl}/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
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
    }
    return resMessage;
  }

  Future<void> getUserData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    String userId = prefs.getString("userId") ?? "";
    String email = prefs.getString("email") ?? "";
    String name = prefs.getString("name") ?? "";
    String accessToken = prefs.getString("accessToken") ?? "";
    String refreshToken = prefs.getString("refreshToken") ?? "";
    UserModel user = UserModel(
        id: userId,
        name: name,
        email: email,
        accessToken: accessToken,
        refreshToken: refreshToken);
    userProvider.setUserFromModel(user);
  }

  @override
  Future<int> forgotPass(String email) async {
    late int statusCode;
    final response = await http.post(
      Uri.parse('${GlobalVariable.apiUrl}/forgotPassword'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "email": email
        },
      ),
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    statusCode = data["status"];
    return statusCode;
  }

  @override
  Future<List<String>> verify(String email, String otp) async {
    List<String> responseString = [];
    late String resMessage;
    final response = await http.post(
      Uri.parse('${GlobalVariable.apiUrl}/verify'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "email": email,
          "OTP": otp
        },
      ),
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    resetUrl = data['metadata']['resetURL'];
    if (resetUrl.contains("localhost")) {
      resetUrl = resetUrl.replaceFirst("localhost", "10.0.2.2");
    }
    responseString.add(resMessage);
    responseString.add(resetUrl);
    return responseString;
  }

  @override
  Future<String> resetPass(String password, String passwordConfirm,
      String token) async {
    late String resMessage;
    final response = await http.post(
      Uri.parse(token),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "password": password,
          "passwordConfirm": password
        },
      ),
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    return resMessage;
  }

  //chat
  //create new user
  @override
  Future<UserCredential> signUpWithEmailAndPass(String email,
      String password, String userId) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        //'uid' : userCredential.user!.uid,
        'uid' : userId,
        'email' : email
      });
      return userCredential;
    }on FirebaseException catch(e){
      throw Exception(e.code);
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPass(String email,
      String password) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email
      }, SetOptions(merge: true));
      return userCredential;
    }on FirebaseException catch(e){
      throw Exception(e.code);
    }
  }
}
