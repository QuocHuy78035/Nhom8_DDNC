import 'package:flutter/cupertino.dart';

abstract class IAuth{
  Future<String> loginUser(String email, String password, BuildContext context);

  Future<String> registerUser(String name, String email, String password, String passwordConfirm, BuildContext context);
}