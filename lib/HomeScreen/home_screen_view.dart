import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_project/CartScreen/cart_screen.dart';
import 'package:e_commerce_project/CategoriesAndFeaturedScreen/categories_and_featured_screen.dart';
import 'package:e_commerce_project/Const/const.dart';
import 'package:e_commerce_project/HomeScreen/Component/drawer..dart';
import 'package:e_commerce_project/HomeScreen/Controller/home_screen_controller.dart';
import 'package:e_commerce_project/ItemScreen/item_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Model/categories_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ecommerce App",
          style: TextStyle(
              fontSize: 15.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CartScreen());
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      drawer: const HomeScreenDrawer(),
      body: SafeArea(
          child: Obx(() => _controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: Colors.blueAccent,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // banner
                      // SizedBox(
                      //     height: 30.h,
                      //     width: double.maxFinite,
                      //     child: PageView.builder(
                      //         controller: _controller.pageController,
                      //         itemCount: _controller.bannerData.length,
                      //         itemBuilder: (context, index) {
                      //           return Padding(
                      //             padding: EdgeInsets.all(3.w),
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                   image: DecorationImage(
                      //                       image: NetworkImage(_controller
                      //                           .bannerData[index].image),
                      //                       fit: BoxFit.cover)),
                      //             ),
                      //           );
                      //         })),

                      CarouselSlider(
                        options: CarouselOptions(
                          height: 30.h,
                          aspectRatio: 2.0,
                          onPageChanged: ((index, reason) {
                            _controller.activeIndex.value = index;
                          }),
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: _controller.bannerData.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical:1.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(i.image),
                                          fit: BoxFit.fill)),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Obx(
                        () => AnimatedSmoothIndicator(
                          activeIndex: _controller.activeIndex.value,
                          count: _controller.bannerData.length,
                          effect: WormEffect(
                            activeDotColor: Colors.black,
                            dotHeight: 2.w,
                            dotWidth: 2.w,
                          ),
                        ),
                      ),

                     

                      // categories..
                      categoriesTitle("All Categories", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CategoriesAndFeaturedScreen(
                                    data: _controller.categoriesData,
                                    title: "All Categories")));
                      }),
                      SizedBox(
                        height: 2.h,
                      ),
                      listViewBuilder(data: _controller.categoriesData),
                      SizedBox(
                        height: 2.h,
                      ),
                      categoriesTitle("Featured", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CategoriesAndFeaturedScreen(
                                    data: _controller.featuredData,
                                    title: "All Featured")));
                      }),
                      SizedBox(
                        height: 2.h,
                      ),
                      listViewBuilder(data: _controller.featuredData),
                    ],
                  ),
                ))),
    );
  }

  Widget listViewBuilder({required List<CategoriesModel> data}) {
    return SizedBox(
        height: 22.h,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return listViewBuilderItems(data[index]);
            }));
  }

  Widget listViewBuilderItems(CategoriesModel data) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: InkWell(
          onTap: () {
            Get.to(() => ItemScreen(
                  categoryTitle: data.title,
                  categoryId: data.id,
                ));
          },
          child: SizedBox(
            height: double.maxFinite,
            width: 30.w,
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(1.w),
                  elevation: 5,
                  child: Container(
                    height: 15.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.w),
                        image: DecorationImage(
                            image: NetworkImage(data.image),
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Expanded(
                    child: Text(
                  data.title,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoriesTitle(String title, Function() function) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      // height: 2.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          InkWell(
              onTap: function,
              child: Text(
                "View More",
                style: TextStyle(color: Colors.blueAccent, fontSize: 13.sp),
              )),
        ],
      ),
    );
  }
}
