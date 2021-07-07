import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInModel extends ChangeNotifier{
  String email = '';
  String pass = '';


  Future logIn() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email.trim(),
        password: pass
    );
  }

}