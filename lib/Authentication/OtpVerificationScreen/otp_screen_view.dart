import 'package:e_commerce_project/Authentication/LoginScreen/login_screen_controller.dart';
import 'package:e_commerce_project/Const/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginScreenController _controller=Get.put(LoginScreenController());

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 15.h,
                width: 30.w,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(230, 233, 250, 1),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(30.w))),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 15.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Verify your\n Phone Number\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Enter the OTP that you have\n recieved through SMS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 11.sp))
                    ])),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 10.h,
              width: 70.w,
              child: PinCodeTextField(
                onChanged: (String value) {},
                length: 6,
                controller: _controller.otp,
                appContext: context,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldHeight:5.h,
                  activeColor: Colors.black54,
                  inactiveColor: Colors.deepPurple,
                  selectedColor: Colors.pink,
                  fieldWidth: 5.h,
                  borderRadius: BorderRadius.circular(1.w),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 5.h,),
            CustomButton(text:"Submit",
                onTap:(){
                  _controller.signInWithPhoneNumber();
                },
                buttonWidth:45.w),
          ],
        ),
      )),
    );
  }
}
