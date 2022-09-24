import 'package:e_commerce_project/AddressScreen/address_screen.dart';
import 'package:e_commerce_project/CartScreen/Controller/cart_screen_controller.dart';
import 'package:e_commerce_project/ItemsDetailsScreen/Models/item_detail_model.dart';
import 'package:e_commerce_project/ItemsDetailsScreen/item_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Const/const.dart';

class CartScreen extends StatelessWidget {
   CartScreen({Key? key}) : super(key: key);
  final _controller=Get.put(CartScreenController());

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CartScreenController>(builder: (value){
      if(!_controller.isLoading){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "My Cart",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 17.sp),
            ),
            backgroundColor: Colors.blueAccent,
          ),
          body: SafeArea(
              child:ListView.builder(
                  itemCount: _controller.productsDetails.length,
                  itemBuilder: (context, index) {
                    return cartItems(_controller.productsDetails[index]);
                  })),
          bottomNavigationBar:_controller.productsDetails.isEmpty?Container():SizedBox(
            height: 8.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rs. ${value.totalPrice}",style: TextStyle(fontSize: 16.sp,fontWeight:FontWeight.w500),),
                  InkWell(
                    onTap: (){
                      Get.to(AddressScreen());

                    },
                    child: Container(
                      height:7.h,
                      width: 40.w,
                      alignment: Alignment.center,
                      color: Colors.blueAccent,
                      child: Text("checkout",style: TextStyle(fontSize:16.sp,color: Colors.white,fontWeight: FontWeight.w500),),
                    ),
                  )



                ],
              ),
            ),
          ),
        );
      }else{
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    },);
  }

  Widget cartItems(ItemDetailModel model){
    int discount = _controller.calculateDiscount(model.totalPrice, model.sellingPrice);
    return Padding(padding:EdgeInsets.symmetric(horizontal: 3.w,vertical:1.h),
    child: InkWell(
      onTap: (){
        Get.to(()=>ItemDetailsScreen(id: model.id));
      },
      child: Container(
        height:25.h,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 1.h),
        decoration: const BoxDecoration(
          border:Border(
            bottom: BorderSide(color: Colors.grey,width: 0.5),
            top:BorderSide(color: Colors.grey,width: 0.5),
          )
        ),
        child: Column(
          children: [
            SizedBox(
              height:11.h,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(1.w),
                    height: double.maxFinite,
                    width: 30.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(model.img),
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(
                      child: SizedBox(
                        child: RichText(
                          text: TextSpan(
                              text: "${model.title}\n",
                              style: TextStyle(
                                  fontSize:12.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: "\$ ${model.totalPrice}",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey.shade500,
                                        decoration: TextDecoration.lineThrough)),
                                TextSpan(
                                  text: " \$ ${model.sellingPrice}",
                                  style: TextStyle(fontSize: 10.sp, color: Colors.black),
                                ),
                                TextSpan(
                                  text: "$discount% off",
                                  style: TextStyle(fontSize: 10.sp, color: Colors.green),
                                )
                              ]),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(height:2.h,),
            Text("Will be Delivered in ${model.deliveryDays} days",style: TextStyle(color:Colors.green,fontWeight:FontWeight.w500,fontSize: 14.sp),),
            ListTile(
              onTap: (){
                _controller.removeFromCart(model.id);
              },
              title: Text("Remove From Cart",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight:FontWeight.w500),),
              trailing: const Icon(Icons.delete),
            )





          ],
        ),
      ),
    ),

    );

  }

}
