import 'package:e_commerce_project/AddressScreen/Controller/address_screen_controller.dart';
import 'package:e_commerce_project/ConfirmtionScreen/confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({Key? key}) : super(key: key);


  final _controller =Get.put(AddressScreenController());

  @override
  Widget build(BuildContext context) {
   return GetBuilder<AddressScreenController>(builder: (value){
     if(value.isAddressAvailable){
       return EditAddressScreen();
     }else{
       return AddAddressScreen();
     }
   });
  }
}

class AddAddressScreen extends StatelessWidget {
   AddAddressScreen({Key? key}) : super(key: key);
  final _controller =Get.put(AddressScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Address",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.sp),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
           TextField(
              controller: _controller.nameController,
              maxLength: 15,
              decoration: const InputDecoration(
                  hintText: "Full Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ))),
            ),
            SizedBox(
              height: 2.h,
            ),
          TextField(
            controller: _controller.addressController,
              maxLines: 5,
              decoration: const InputDecoration(
                  hintText: "Address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ))),
            ),
            SizedBox(
              height: 2.h,
            ),
          TextField(
            controller: _controller.pinCodeController,
              maxLength: 6,
              decoration: const InputDecoration(
                  hintText: "Pin code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ))),
            )
          ],
        ),
      )),
      bottomNavigationBar: InkWell(
        onTap: () {
          _controller.onTap();
        },
        child: Container(
          height: 6.h,
          color: Colors.blueAccent,
          alignment: Alignment.center,
          child: Text(
            "Save",
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class EditAddressScreen extends StatelessWidget {
 EditAddressScreen({Key? key}) : super(key: key);
  final _controller =Get.put(AddressScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Address",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.sp),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          addressCard(),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: (){
          Get.to(ConfirmationScreen());
        },
        child: Container(
          height: 6.h,
          color: Colors.blueAccent,
          alignment: Alignment.center,
          child: Text("Proceed",style: TextStyle(fontSize: 19.sp,color: Colors.white,fontWeight: FontWeight.w500),),
        ),
      ),
    );
  }

  Widget addressCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Material(
        elevation: 5,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
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
              Text(_controller.pincode,style: TextStyle(fontSize:16.sp,fontWeight: FontWeight.w500),),
              SizedBox(height: 3.h,),
              InkWell(
                onTap: (){
                  _controller.onEdit();
                },
                child: Container(
                  color: Colors.blueAccent,
                  alignment: Alignment.center,
                  height:5.h,
                  child: Text("Edit",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.sp,color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
