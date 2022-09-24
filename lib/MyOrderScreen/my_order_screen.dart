import 'package:e_commerce_project/MyOrderScreen/Controller/my_order_controller.dart';
import 'package:e_commerce_project/MyOrderScreen/Model/my_order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../Const/const.dart';
import '../MyOrderDetailsScreen/my_order_details_screen.dart';


class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller=Get.put(MyOrderController());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.blueAccent,
      ),
      body:Obx(()=>_controller.isLoading.value?const Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount:_controller.model.length,
            itemBuilder: (context,index){
          return listViewBuilderItems(_controller.model[index]);
        }),
      ),
    );
  }
  Widget listViewBuilderItems(MyOrdersModel model) {

    return InkWell(
      onTap:(){
        Get.to(MyOrderDetailsScreen(model: model,));
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical:0.8.h,horizontal:3.w),
        child: Container(
          padding: EdgeInsets.all(1.w),
          height: 12.h,
          width: double.infinity,
          child: Row(
            children: [
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  height: double.maxFinite,
                  width: 26.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(model.image),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Expanded(
                  child: SizedBox(
                    child: RichText(
                      text: TextSpan(
                          text: "${model.name}\n",
                          style: TextStyle(
                              fontSize:14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text:model.status==0? "Status : Pending":"Status : Delivered",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey.shade500,
                                  )),


                          ]),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

}
