import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/MyOrderScreen/Model/my_order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController{


@override
  void onInit() {
    // TODO: implement onInit
    getMyOrders();
    super.onInit();
  }

final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
final FirebaseAuth _auth=FirebaseAuth.instance;



List<MyOrdersModel> model=[];
var isLoading =false.obs;

Future<void> getMyOrders()async{
isLoading(true);
try{
  await _firebaseFirestore.collection('users').doc(_auth.currentUser!.uid).collection('myorders').get().then((value) {

model =value.docs.map((e) => MyOrdersModel.fromJson(e.data())).toList();
isLoading(false);
update();


  });






}catch (e){}


}


}