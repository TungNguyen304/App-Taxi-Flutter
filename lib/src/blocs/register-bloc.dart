import 'dart:async';

import 'package:flutter_application_1/src/validators/validation.dart';

class RegisterBloc {
  final StreamController emailController = StreamController();
  final StreamController passwordController = StreamController();
  final StreamController nameController = StreamController();
  final StreamController phoneController = StreamController();

  Stream get emailStream => emailController.stream;
  Stream get passwordStream => passwordController.stream;
  Stream get nameStream => nameController.stream;
  Stream get phoneStream => phoneController.stream;

  bool isValidInfo(String email, String password, String name, String phone) {
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
    if(Validation.isEmpty(name)) {
      nameController.addError("Name không được để trống");
      valid = false;
    } else {
      nameController.add(true);
    }
    if(Validation.isEmpty(phone)) {
      phoneController.addError("Phone không được để trống");
      valid = false;
    } else {
      phoneController.add(true);
    }
    return valid;
  }

  void dispose() {
    emailController.close();
    passwordController.close();
    nameController.close();
    phoneController.close();
  }
}