import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/AddressScreen/Controller/address_screen_controller.dart';
import 'package:e_commerce_project/CartScreen/Controller/cart_screen_controller.dart';
import 'package:e_commerce_project/HomeScreen/home_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class ConfirmtionScreenController extends GetxController {
  final _addressController = Get.put(AddressScreenController());
  final _cardController = Get.put(CartScreenController());
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // final Razorpay _razorpay = Razorpay();

  String name = "", address = "", pinCode = "";
  int totalPrice = 0, discount = 0, payablePrice = 0;

  void initializeData() {
    name = _addressController.name;
    address = _addressController.address;
    pinCode = _addressController.pincode;
    totalPrice = _cardController.totalPrice;
    discount = _cardController.totalDiscount;
    payablePrice = _cardController.totalSellingPrice;
  }

  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment() async {
    try {
      String orderId=uuid.v1();
      paymentIntentData = await createPaymentIntent(_cardController.totalSellingPrice.toString(), 'USD');
      //Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan')).then((value){


                print("payment commplited");
      });


      ///now finally display payment sheeet
      displayPaymentSheet(orderId);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String orderId) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      Fluttertoast.showToast(msg: "Payment Successful");
      await Future.wait([
    placeOrder(orderId),
    addToMyOrders(orderId),
  ]).then((value) {
    Get.off(const HomeScreen());
  });
     
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51LkmU1KiBkD0AAsGlYMb9l6QepyUbHgolMliI2YSNdcN8uJTR0Kk6AtqN6lnhKhzuN6lMKqkohZxwGoer3pbDdlF00CAsaB6yo',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }
  //
  // calculateAmount(String amount) {
  //   final a = (int.parse(amount)) * 100;
  //   return a.toString();
  // }





  // void onPay() {
  //   var options = {
  //     'key': '<YOUR_KEY_HERE>',
  //     'amount': _cardController.totalSellingPrice,
  //     'name': 'Acme Corp.',
  //     'description': 'Fine T-Shirt',
  //     'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
  //   };

  //   _razorpay.open(options);
  // }

//   @override
//   void onInit() {
//     // TODO: implement onInit

// _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
// _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
// _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     super.onInit();
//   }

Future<void> placeOrder(String orderId)async{
  try{
Map<String,dynamic> details={
   'orderId': orderId,
        'productIds': _cardController.productIds,
        'name': name,
        'address': address,
        'pincode': pinCode,
        'mobile': _auth.currentUser!.phoneNumber,
        'status': 0,
        'time': FieldValue.serverTimestamp(),

};

    await _firebaseFirestore.collection('orders').add(details);

  }catch (e){
    print(e.toString());
  }
}

Future<void> addToMyOrders(String orderId)async {
  try{
      for(var i=0;i<_cardController.productsDetails.length;i++){
          Map<String,dynamic> orderDetails={

          'img': _cardController.productsDetails[i].img,
          'name': _cardController.productsDetails[i].title,
          'orderId': orderId,
          'total_price': _cardController.productsDetails[i].totalPrice,
          'paid_amount': _cardController.productsDetails[i].sellingPrice,
          'status': 0,
          'oder_on': FieldValue.serverTimestamp(),
          'deliver_on': FieldValue.serverTimestamp()

          };

           await _firebaseFirestore.collection('users').doc(_auth.currentUser!.uid).collection('myorders').add(orderDetails);

      }

  }catch (e){
  print(e.toString());
  }

 }

// void _handlePaymentSuccess(PaymentSuccessResponse response)async {
//   await Future.wait([
//     placeOrder(response.orderId??""),
//     addToMyOrders(response.orderId??""),
//   ]).then((value){

// Fluttertoast.showToast(msg: "Payment Sucessfull");
// Get.to(const HomeScreen());

//   });

// }

// void _handlePaymentError(PaymentFailureResponse response) {
//   // Do something when payment fails
//   Fluttertoast.showToast(msg: "Payment Failed");
// }

// void _handleExternalWallet(ExternalWalletResponse response) {
//   // Do something when an external wallet was selected
//   Fluttertoast.showToast(msg: "Payment failed");
// }

}
