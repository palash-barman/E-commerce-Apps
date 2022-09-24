

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/ItemsDetailsScreen/Models/item_detail_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ItemsDetailsScreenController extends GetxController{
  final pageController=PageController();
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth =FirebaseAuth.instance;
  var isLoading =false.obs;
  var isAlreadyAvailable=false;
  late ItemDetailModel model;
  int discount=0;

  Future<void> getItemDetails(String id)async {
    isLoading(true);
    try{
      await _firestore.collection('products').doc(id).get().then((value){
        model =ItemDetailModel.fromJson(value.data()!);
        discount=calculateDiscount(model.totalPrice,model.sellingPrice);
        isLoading(false);
      });
    }catch (e){
      print(e.toString());
    }

  }

  Future<void> checkIfAlreadyInCart()async{
    isLoading(true);
    try{
      await _firestore.collection("users").doc(_auth.currentUser!.uid).collection('cart').where('id',isEqualTo: model.id).get().then((value){
        if(value.docs.isNotEmpty){
          isAlreadyAvailable=true;
        }
        isLoading(false);
        update();
      });


    }catch (e){
      isLoading(false);
      print(e.toString());
    }


  }

  Future<void> addItemsToCart()async{
    isLoading(true);
    update();
    try{
        await _firestore.collection("users").doc(_auth.currentUser!.uid).collection('cart').doc(model.id).set({'id':model.id}).then((value){
          checkIfAlreadyInCart();
        });



    }catch (e){
      print(e.toString());
    }


  }


  int calculateDiscount(int totalPrice,int sellingPrice){
    double dicount=((totalPrice-sellingPrice)/totalPrice)*100;

    return discount.toInt();
  }



}