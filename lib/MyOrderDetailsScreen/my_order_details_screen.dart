import 'package:e_commerce_project/CartScreen/cart_screen.dart';
import 'package:e_commerce_project/MyOrderScreen/Model/my_order_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Const/const.dart';


class MyOrderDetailsScreen extends StatelessWidget {
  MyOrderDetailsScreen({Key? key,required this.model}) : super(key: key);
    MyOrdersModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text(model.name),
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child:Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 25.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(model.image),fit: BoxFit.fill
                )
              ),
            ),
            SizedBox(height: 3.h,),
            Text(model.name,style: TextStyle(fontSize:19.sp,fontWeight: FontWeight.w500),),
            SizedBox(height: 3.h,),
            orderDetails()


          ],
        ),
      ),
    );
  }

  Widget orderDetails() {
    Widget text(String header, String footer) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            maxLines: 2,
            style:  TextStyle(
              fontSize: 16.sp,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis
            ),
          ),
          Expanded(
            child: Text(
              footer,
              maxLines: 2,
              style:  TextStyle(
                fontSize: 16.sp,
                color: Colors.amber,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );
    }

    return Material(
      elevation: 5,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 3.w,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "Order Details",
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height:1.h,
            ),
            
            text('Order Id : ', model.orderId),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: text('Total Price : ', model.totalPrice.toString()),
            ),
            text('Paid amount : ', model.paidAmount.toString()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child:
              text('Status : ', model.status==0?"Pending":"Delivered"),
            ),
            text('Ordered on : ', model.deliverON),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 12),
            //   child: text('Delivered on :', '28-10-2021'),
            // ),
          ],
        ),
      ),
    );
  }
}
