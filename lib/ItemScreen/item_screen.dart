import 'package:e_commerce_project/ItemScreen/Controller/items_screen_controller.dart';
import 'package:e_commerce_project/ItemScreen/Model/item_model.dart';
import 'package:e_commerce_project/ItemScreen/SearchDelegate/search_delegate_screen.dart';
import 'package:e_commerce_project/ItemsDetailsScreen/item_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Const/const.dart';

class ItemScreen extends StatelessWidget {
  final String categoryId, categoryTitle;

  ItemScreen({Key? key, required this.categoryTitle, required this.categoryId})
      : super(key: key);

  final _controller = Get.put(ItemsScreenController());

  @override
  Widget build(BuildContext context) {
    _controller.categoryId = categoryId;
    _controller.categoryTitle = categoryTitle;

    _controller.getPginedData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
          style: TextStyle(fontSize: 16.sp),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            searchBar(context),
            SizedBox(
              height: 1.h,
            ),
            Expanded(
                child: Obx(
              () => _controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount:_controller.itemsData.length,
                      itemBuilder: (context, index) {
                        return listViewBuilderItems(_controller.itemsData[index]);
                      }),
            )),
            Obx((){
              if(_controller.isLoading1.value){
                return Container(
                  height: 10.h,
                  width:double.infinity,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              } else{
                return const SizedBox();
              }
            })
          ],
        ),
      )),
    );
  }

  Widget listViewBuilderItems(ItemsModel model ) {
    int discount=_controller.calculateDiscount(model.totalPrice, model.sellingPrice);
    return InkWell(
      onTap:(){
        Get.to(()=>ItemDetailsScreen(id: model.id,));
      },
      child: Card(
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
      ),
    );
  }

  Widget searchBar(BuildContext context ) {
    return GestureDetector(
      onTap: (){
        showSearch(context: context, delegate: SearchScreen());
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(1.5.w),
        color: Colors.grey.shade200,
        child: Container(
          height: 5.5.h,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search Here...",
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              Icon(
                Icons.search,
                size:20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
