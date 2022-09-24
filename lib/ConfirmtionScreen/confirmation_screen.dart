import 'package:e_commerce_project/ConfirmtionScreen/Controller/confirmtion_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ConfirmationScreen extends StatelessWidget {
   ConfirmationScreen({Key? key}) : super(key: key);
  final _controller=Get.put(ConfirmtionScreenController());

  @override
  Widget build(BuildContext context) {
    _controller.initializeData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Confirmation",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            addressCard(),
            SizedBox(
              height: 2.h,
            ),
            orderDetails(),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          _controller.makePayment();
        },
        child: Container(
          height: 6.h,
          color: Colors.blueAccent,
          alignment: Alignment.center,
          child: Text(
            "Pay Now",
            style: TextStyle(
                fontSize: 17.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget addressCard() {
    return Material(
      elevation: 5,
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _controller.name,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text(
                _controller.address,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Text(
              _controller.pinCode,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderDetails() {
    Widget text(String header, String footer) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: Colors.redAccent, 
            ),
          ),
          Text(footer,style: TextStyle(fontSize: 16.sp,fontWeight:FontWeight.w500),),
        ],
      );
    }

    return Material(
      elevation: 5,
      color: Colors.white,
      child:Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price Details",style: TextStyle(fontSize: 19.sp,fontWeight: FontWeight.w500,color:Colors.blueAccent),),
            SizedBox(height:2.h,),
            text("Total Price :", "Rs.${_controller.totalPrice}"),
            SizedBox(height: 2.h,),
            text("Discount :", "Rs. ${_controller.discount}"),
            SizedBox(height: 2.h,),
            text("Payable Price :", "Rs. ${_controller.payablePrice}"),

          ],
        ),
      ),
    );
  }
}
