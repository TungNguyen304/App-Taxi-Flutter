import 'dart:async';

import 'package:flutter_application_1/src/validators/validation.dart';

class LoginBloc {
  final StreamController emailController = StreamController();
  final StreamController passwordController = StreamController();

  Stream get emailStream => emailController.stream;
  Stream get passwordStream => passwordController.stream;

  bool isValidInfo(String email, String password) {
    bool valid = true;
    if(Validation.isEmpty(email)) {
      emailController.addError("Email không được để trống");
      valid = false;
    } else {
      emailController.add(true);
    }
    if(Validation.isEmpty(password)) {
      passwordController.addError("Password không được để trống");
      valid = false;
    } else {
      passwordController.add(true);
    }
    return valid;
  }

  void dispose() {
    emailController.close();
    passwordController.close();
  }
}