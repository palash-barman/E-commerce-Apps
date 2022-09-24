import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final BorderRadius? radius;
   Function() onTap;
  final double buttonWidth;
   CustomButton({Key? key, required this.text, this.radius, required this.onTap, required this.buttonWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Material(
        elevation: 5,
        borderRadius: radius??BorderRadius.circular(2.w),
        color: const Color.fromRGBO(30, 62, 160, 1),
        child: Container(
          height: 5.h,
          width: buttonWidth,
          alignment: Alignment.center,
          child: Text(text,style: TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.w500),),
        ),
      ),
    );
  }
}
