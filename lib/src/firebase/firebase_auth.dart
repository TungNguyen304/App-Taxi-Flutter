import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signUp(String email, String password, String name, String phone, Function onSuccess, Function onFailure) async {
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await createUser(user.user?.uid as String, name, phone, onSuccess, onFailure);
    } on FirebaseAuthException catch (error) {
      onFailure(error.message, error.code);
    }
  }

  Future createUser(String userId, String name, String phone, Function onSuccess, Function onFailure) async {
    DatabaseReference users = FirebaseDatabase.instance.ref("users/$userId");
    try {
      await users.set({
      "name": name,
      "phone": phone,
      });
      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFailure(error.message, error.code);
    }
  }

  Future signIn(String email, String password, Function onSuccess, Function onFailure) async {
    try {
      var response = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFailure(error.message, error.code);
    }
  }
}