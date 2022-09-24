

import 'package:e_commerce_project/Authentication/LoginScreen/login_screen_controller.dart';
import 'package:e_commerce_project/Authentication/OtpVerificationScreen/otp_screen_view.dart';
import 'package:e_commerce_project/Const/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final LoginScreenController _controller=Get.put(LoginScreenController());

      return Scaffold(
          body: Obx(()=>
            _controller.isLoading.value?Center(child:SizedBox(height: 10.w,width: 10.w,child: CircularProgressIndicator(
              strokeWidth: 1.w,
              color: Colors.blue,
            ),),) :SingleChildScrollView(
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.w)),
                    color: const Color.fromRGBO(230, 233, 250, 1),
                    child: SizedBox(
                      height: 50.h,
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text("E- Commerce",style: TextStyle(fontSize: 21.sp, color: const Color.fromRGBO(
                                9, 32, 196, 1),fontWeight: FontWeight.bold,letterSpacing: 1.2 ),),
                          ),
                          SizedBox(height: 1.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text(" 'It's all easy when it's at Home' ",style: TextStyle(  color: const Color.fromRGBO(
                                90, 106, 165, 1),fontSize: 14.sp,fontWeight: FontWeight.w500),),
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              Container(
                                height: 8.h,
                                width: 1.w,
                                margin: EdgeInsets.only(left: 5.w),
                                color: const Color.fromRGBO(
                                    9, 32, 196, 1),
                              ),
                              SizedBox(width:2.w,),
                              RichText(text: TextSpan(
                                  text: "Welcome\n",
                                  style: TextStyle(
                                      fontSize: 17.sp,color: Colors.black,fontWeight: FontWeight.w500
                                  ),
                                  children: [
                                    TextSpan(
                                        text:"Enter the Details to login/Signup.",
                                        style: TextStyle(fontWeight: FontWeight.w500,  color: const Color.fromRGBO(
                                            138, 132, 134, 1),fontSize:11.sp )
                                    )
                                  ]
                              ))


                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: TextField(
                      maxLength:10,
                      controller: _controller.phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefix:Text("+880 ",style: TextStyle(fontSize: 12.sp,color: Colors.grey.shade400),),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.w),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromRGBO(9, 32, 196, 1),
                            )
                        ),
                        focusedBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.w),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromRGBO(9, 32, 196, 1),
                            )
                        ),
                        hintText: "Phone Number",
                        counterText: "",

                      ),
                    ),
                  ),
                  SizedBox(
                    height:10.h,
                  ),

                  CustomButton(
                    text: "Login/SignUp",
                    onTap: (){
                     _controller.verifyPhoneNumber();
                    },
                    buttonWidth: 45.w, ),






                ],

              ),
            )
          ),

      );
    
  }
}