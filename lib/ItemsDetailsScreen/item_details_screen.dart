import 'package:e_commerce_project/CartScreen/cart_screen.dart';
import 'package:e_commerce_project/Const/const.dart';
import 'package:e_commerce_project/ItemsDetailsScreen/Controller/item_details_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemDetailsScreen extends StatelessWidget {
  String id;
  ItemDetailsScreen({Key? key, required this.id}) : super(key: key);
  final _controller = Get.put(ItemsDetailsScreenController());

  @override
  Widget build(BuildContext context) {

    _controller.getItemDetails(id);
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Obx(
          () => _controller.isLoading.value
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: Text(_controller.model.title),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => CartScreen());
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          size: 25.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 3.w,)
                    ],
                    backgroundColor: Colors.blueAccent,
                  ),
                  body: SafeArea(
                      child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 33.h,
                            width: double.maxFinite,
                            child: PageView.builder(
                                controller: _controller.pageController,
                                itemCount: _controller.model.banners.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(3.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: NetworkImage(_controller.model.banners[index]),fit: BoxFit.fill
                                      )),
                                    ),
                                  );
                                })),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _controller.pageController,
                            count:_controller.model.banners.length,
                            effect: WormEffect(
                              activeDotColor: Colors.black,
                              dotHeight: 2.w,
                              dotWidth: 2.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                         _controller.model.title,
                          style: TextStyle(
                              fontSize: 23.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        RichText(
                          text: TextSpan(text: "", children: [
                            TextSpan(
                              text: "\$ ${_controller.model.totalPrice}",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey.shade500,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            TextSpan(
                              text: " \$ ${_controller.model.sellingPrice}",
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.black),
                            ),
                            TextSpan(
                              text: " ${_controller.discount}% off",
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.green),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          _controller.model.description,
                          style: TextStyle(fontSize: 12.sp, color: Colors.black),
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        ListTile(
                          onTap: () {},
                          title: Text(
                            "See Reviews",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          leading: Icon(Icons.star),
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                      ],
                    ),
                  )),
                  bottomNavigationBar: SizedBox(
                    height: 6.5.h,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                            child: customButton(
                                () {
                                  if(_controller.isAlreadyAvailable){
                                    Get.to(()=> CartScreen());
                                  }else{
                                    _controller.addItemsToCart();
                                  }

                                }, Colors.redAccent,_controller.isAlreadyAvailable?"Go to Cart": "Add to Cart")),
                        Expanded(
                            child: customButton(() {}, Colors.white, "Buy Now"))
                      ],
                    ),
                  ),
                ),

      ),
      ),
    );
  }

  Widget customButton(Function() onTap, Color color, String title) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 16.sp,
              color: color == Colors.redAccent ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
