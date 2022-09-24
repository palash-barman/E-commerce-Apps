

import 'package:e_commerce_project/Authentication/LoginScreen/login_screen_view.dart';
import 'package:e_commerce_project/HomeScreen/home_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Authentication extends StatelessWidget {
 Authentication({Key? key}) : super(key: key);
  final FirebaseAuth auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    if(auth.currentUser != null){
      return const HomeScreen();
    }else{
      return const LoginScreen();
    }
    
  }
}