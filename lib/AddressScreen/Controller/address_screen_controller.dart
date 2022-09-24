
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreenController extends GetxController{
  final nameController=TextEditingController();
  final addressController=TextEditingController();
  final pinCodeController=TextEditingController();
  late SharedPreferences _preferences;
  bool isAddressAvailable=false;
  String name="",address="",pincode="";






  Future<void> getInstance()async{
    _preferences=await SharedPreferences.getInstance();
    String? address=_preferences.getString('address');
    if(address!.isNotEmpty){
      isAddressAvailable=true;
    }else{
      isAddressAvailable=false;
    }
    getData();
    update();
  }

  getData(){
     name=_preferences.getString('name')!;
     address=_preferences.getString('address')!;
     pincode=_preferences.getString('pincode')!;
  }


  void onEdit()async{
    isAddressAvailable=false;
    update();
    await _preferences.clear();
  }



  void onTap()async{
    if(nameController.text.isNotEmpty&&addressController.text.isNotEmpty&&pinCodeController.text.isNotEmpty){
      await _preferences.setString('name', nameController.text.trim());
      await _preferences.setString("address", addressController.text.trim());
      await _preferences.setString('pincode', pinCodeController.text.trim());
      getInstance();

      print("submit: save");
    }else{
      Fluttertoast.showToast(msg: "All fields are required");
    }
  }



@override
  void onInit() {
    // TODO: implement onInit
  getInstance();
    super.onInit();
  }





}