import 'package:e_commerce_project/ItemScreen/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../HomeScreen/Model/categories_model.dart';

class CategoriesAndFeaturedScreen extends StatelessWidget {
  CategoriesAndFeaturedScreen(
      {Key? key, required this.data, required this.title})
      : super(key: key);
  List<CategoriesModel> data;
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(fontSize: 15.sp, color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: SafeArea(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
            itemCount: data.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return gridItems(data[index]);
              }),
        ));
  }

  Widget gridItems(CategoriesModel data) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
        child: InkWell(
          onTap: () {
          Get.to(ItemScreen(categoryTitle:data.title, categoryId:data.id,));
          },
          child: SizedBox(
            height: double.maxFinite,
            width: 30.w,
            child: Column(
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(1.w),
                  child: Container(
                    height: 15.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.w),
                        image: DecorationImage(
                            image: NetworkImage(data.image), fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Expanded(
                    child: Text(
                  data.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
