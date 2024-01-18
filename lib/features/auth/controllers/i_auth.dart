import 'package:flutter/cupertino.dart';

abstract class IAuth{
  Future<String> loginUser(String email, String password, BuildContext context);
  Future<String> registerUser(String name, String email, String password, String passwordConfirm, BuildContext context);
  Future<int> forgotPass(String email);
  Future<List<String>> verify(String email, String otp);
  Future<String> resetPass(String password, String passwordConfirm, String token);
}