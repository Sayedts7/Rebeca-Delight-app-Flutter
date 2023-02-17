import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rebeca_delight/main.dart';
import 'package:flutter/material.dart';


class SplashServices{

  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null){
      Timer(const Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/home')  );

    }
    else{
      Timer(const Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/login'));

          }


  }
}