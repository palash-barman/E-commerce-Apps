import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/ItemScreen/Model/item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ItemsScreenController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final ScrollController scrollController = ScrollController();

  String categoryId = "";
  String categoryTitle = "";
  List<ItemsModel> itemsData = [];
  List<ItemsModel> searchData = [];
  RxBool isLoading = false.obs;
  RxBool isSearchLoading = false.obs;
  bool hasModeData = true;
  var isLoading1 = false.obs;
  DocumentSnapshot? lastDocument;
  int documentLimit = 7;

  // Future<void> getSubCategoryData() async {
  //   isLoading(true);
  //   try {
  //     await _fireStore
  //         .collection("categories")
  //         .doc(categoryId)
  //         .collection(categoryTitle)
  //         .get()
  //         .then((value) {
  //       itemsData =
  //           value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();
  //       isLoading(false);
  //       print("$categoryId , $categoryTitle work: ${value.docs.length}");
  //       update();
  //     }).catchError((error) => print("error $error"));
  //   } catch (e) {
  //     print(e.toString());
  //     print("error : $e");
  //   }
  // }


  void getPginedData()async{
    if(hasModeData){
      if(!isLoading1.value){
        await getSubCategoryDataParts();
      }
    }else{
      print("No More Data");
    }

  }

  Future<void> getSubCategoryDataParts() async {
    if (lastDocument == null) {
      isLoading(true);
      await _fireStore
          .collection("categories")
          .doc(categoryId)
          .collection(categoryTitle)
          .orderBy('title')
          .limit(documentLimit)
          .get()
          .then((value) {
        itemsData.addAll(value.docs.map((e) => ItemsModel.fromJson(e.data())));
        isLoading(false);
        update();
        lastDocument = value.docs.last;
        if (value.docs.length < documentLimit) {
          hasModeData = false;
        }
      });
    } else {
      isLoading1(true);
      await _fireStore
          .collection("categories")
          .doc(categoryId)
          .collection(categoryTitle)
          .orderBy('title')
          .startAfterDocument(lastDocument!)
          .limit(documentLimit)
          .get()
          .then((value) {
        itemsData.addAll(value.docs.map((e) => ItemsModel.fromJson(e.data())));
        isLoading1(false);
        update();
        lastDocument = value.docs.last;
        if (value.docs.length < documentLimit) {
          hasModeData = false;
        }
      });
    }
  }

  // discount method

  int calculateDiscount(int totalPrice, int sellingPrice) {
    double discount = ((totalPrice - sellingPrice) / totalPrice) * 100;
    return discount.toInt();
  }

  // search delegate
  Future<void> searchProducts(String query) async {
    if (query.isNotEmpty) {
      isSearchLoading(true);
      Future.delayed(Duration.zero, () {
        update();
      });
      try {
        await _fireStore
            .collection("categories")
            .doc(categoryId)
            .collection(categoryTitle)
            .where("title", isGreaterThanOrEqualTo: query)
            .get()
            .then((value) {
          searchData =
              value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();
          isSearchLoading(false);
          update();
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
