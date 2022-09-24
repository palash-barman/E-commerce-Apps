import 'package:e_commerce_project/Authentication/LoginScreen/login_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import 'Authentication/authentication.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=
  "pk_test_51LkmU1KiBkD0AAsGedgsDaaQkFjrzTQ74aUNsdlMnIdv7Pw48oZG4dlIKragfB9Lqq9ff643IeEiQBErSZqAkWjG00QnEGIJuN";
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          home: Authentication(),
        );
      }
      );





    
  }
}