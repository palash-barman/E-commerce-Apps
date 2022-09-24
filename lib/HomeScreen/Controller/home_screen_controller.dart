

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/HomeScreen/Model/banner_data_model.dart';
import 'package:e_commerce_project/HomeScreen/Model/categories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController{

  PageController pageController=PageController();

  final FirebaseFirestore  _firestore=FirebaseFirestore.instance;
    late List<BannerDataModel> bannerData;
    late List<CategoriesModel> categoriesData;
    late List<CategoriesModel> featuredData;
    RxBool isLoading=true.obs;
    var activeIndex=0.obs;
    List<RxBool> isSelected=[];

@override
  void onInit() {
    // TODO: implement onInit
      getAllData();
    super.onInit();
  }



    void getAllData()async{
      await Future.wait([
        getBannerData(),
        getAllCategories(),
       getFeaturedData(),
      ]).then((value){
        print("Data");
        print(bannerData[0].image);
        print(categoriesData[0].id);
        print(featuredData[1].id);
        isLoading(false);
        update();
      });
    }




  Future<void> getBannerData()async{
      await _firestore.collection("banner").get().then((value){
        bannerData=value.docs.map((e) => BannerDataModel.fromJson(e.data())).toList();

      });

  }

  Future<void> getAllCategories()async{
    await _firestore.collection("categories").get().then((value){

      categoriesData =value.docs.map((e) => CategoriesModel.fromJson(e.data())).toList();

    });
  }

  Future<void> getFeaturedData()async{
    await _firestore.collection("featured").get().then((value){
      featuredData=value.docs.map((e) =>CategoriesModel.fromJson(e.data())).toList();
    });
  }





}