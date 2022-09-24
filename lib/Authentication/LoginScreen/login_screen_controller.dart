

import 'package:e_commerce_project/Authentication/OtpVerificationScreen/otp_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../HomeScreen/home_screen_view.dart';

class LoginScreenController extends GetxController{

    TextEditingController phone=TextEditingController();
    TextEditingController otp=TextEditingController();
   final FirebaseAuth _auth=FirebaseAuth.instance;
   String verificationId="";
   RxBool isLoading=false.obs;

   void verifyPhoneNumber()async{
     isLoading(true);
     update();
     try{
      await _auth.verifyPhoneNumber(
          phoneNumber: "+880${phone.text}",
          verificationCompleted: (PhoneAuthCredential credential)async{
            await _auth.signInWithCredential(credential);
            Fluttertoast.showToast(msg: "Verified");
          },
          verificationFailed: (FirebaseException exception){
            Fluttertoast.showToast(msg: "Verification Failed");
          },
          codeSent: (String _verificationId,int? forceRespondToken){
            Fluttertoast.showToast(msg: "Verification code sent");
            verificationId=_verificationId;
            Get.to(const OtpVerificationScreen());
          },
          codeAutoRetrievalTimeout: (String _verificationId){
            verificationId=_verificationId;

          });

     }catch (e){
       isLoading(false);
       Fluttertoast.showToast(msg: e.toString());
     }


   }



   void signInWithPhoneNumber()async{
     try{
       final AuthCredential credential =PhoneAuthProvider.credential(
           verificationId: verificationId
           , smsCode: otp.text);
       var signInUser=await _auth.signInWithCredential(credential);
       final User? user = signInUser.user;
       Fluttertoast.showToast(msg: "Sign In Successfully, User UID : ${user!.uid}");
       Get.off(HomeScreen());
       print("Sign In Successfully, user Uid: ${user.uid}");
     }catch (e){
       Fluttertoast.showToast(msg: "Error Occurred: $e");
     }

   }

}