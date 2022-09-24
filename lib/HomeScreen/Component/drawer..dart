import 'package:e_commerce_project/MyOrderScreen/my_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Column(
        children: [
          UserAccountsDrawerHeader(accountName: const Text("Name"),
              accountEmail:const Text("email@gmail.com"),
          currentAccountPicture: Icon(Icons.account_circle,size:55.sp,color: Colors.white,),

          ),
          ListTile(
            onTap: (){
              Get.to(const MyOrderScreen());
            },
            leading: const Icon(Icons.shopping_bag),
            title: Text("My Orders",style: TextStyle(fontSize:16.sp,color: Colors.black,fontWeight: FontWeight.w500),),

          )




        ],
      ),
    );
  }
}
