

import 'package:e_commerce_project/ItemScreen/Controller/items_screen_controller.dart';
import 'package:e_commerce_project/ItemScreen/Model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends SearchDelegate{
  final _controller=Get.put(ItemsScreenController());
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(onPressed: (){

      }, icon:const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      Get.back();
    }, icon:const Icon(Icons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {
    _controller.searchProducts(query);
    return Obx(
          () => _controller.isSearchLoading.value
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
          itemCount:_controller.searchData.length,
          itemBuilder: (context, index) {
            return listViewBuilderItems(_controller.searchData[index]);
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _controller.searchProducts(query);
    return Obx(
          () => _controller.isSearchLoading.value
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
          itemCount:_controller.searchData.length,
          itemBuilder: (context, index) {
            return listViewBuilderItems(_controller.searchData[index]);
          }),
    );

  }

  Widget listViewBuilderItems(ItemsModel model ) {
    int discount=_controller.calculateDiscount(model.totalPrice, model.sellingPrice);
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical:0.5.h),
      child: SizedBox(
        height: 9.h,
        width: double.infinity,
        child: Row(
          children: [
            Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(1.w),
                height: double.maxFinite,
                width: 20.w,
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
                            text: " $discount% off",
                            style: TextStyle(fontSize: 10.sp, color: Colors.green),
                          )
                        ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }




}