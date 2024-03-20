import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';
import 'package:inam_ecomerce_app/Screens/CheckoutScreen.dart';
import 'package:inam_ecomerce_app/Screens/HomeScreen.dart';
import 'package:inam_ecomerce_app/Screens/NumberVerification.dart';
import 'package:inam_ecomerce_app/Screens/OTPVerification.dart';
import 'package:inam_ecomerce_app/Screens/OrderListScreen.dart';
import 'package:inam_ecomerce_app/Screens/ProductScreens.dart';
import 'package:inam_ecomerce_app/Screens/ProfileScreen.dart';
import 'package:inam_ecomerce_app/Screens/RegisterScreen.dart';

import '../Controllers/HomeController.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      body: Obx(() => controller.isHomeScreen.value?
          HomeScreen() :
          controller.isCheckOutScreen.value?
              CheckoutPage() :
              controller.isProductScreen.value?
                  ProductScreen() :
                  controller.isNumberVerificationScreen.value?
                      NumberVerification() :
                      controller.isOrderListScreen.value?
                          OrderListScreen() :
                          controller.isOTPVerificationScreen.value?
                              OTPVerification() :
                              controller.isProfileScreen.value?
                                  PRofileScreen() :
                                  controller.isRegisterScreen.value?
                                      RegisterScreen() :
                                      Container(),
      ),
      bottomNavigationBar: Obx(() =>
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      controller.isHomeScreen.value = true;
                      controller.isCheckOutScreen.value = false;
                      controller.isProfileScreen.value = false;
                      controller.isProductScreen.value = false;
                      controller.isNumberVerificationScreen.value = false;
                      controller.isOrderListScreen.value = false;
                      controller.isOTPVerificationScreen.value = false;
                    },
                    child: Icon(Icons.home, color:controller.isHomeScreen.value? AppColors.backgroundColor :Colors.black,),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      controller.isHomeScreen.value = false;
                      controller.isCheckOutScreen.value = true;
                      controller.isProfileScreen.value = false;
                      controller.isProductScreen.value = false;
                      controller.isNumberVerificationScreen.value = false;
                      controller.isOrderListScreen.value = false;
                      controller.isOTPVerificationScreen.value = false;
                    },
                    child: Icon(Icons.shopping_cart, color:controller.isCheckOutScreen.value? AppColors.backgroundColor: Colors.black,),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      controller.isHomeScreen.value = false;
                      controller.isCheckOutScreen.value = false;
                      controller.isProfileScreen.value = true;
                      controller.isProductScreen.value = false;
                      controller.isNumberVerificationScreen.value = false;
                      controller.isOrderListScreen.value = false;
                      controller.isOTPVerificationScreen.value = false;
                    },
                    child: Icon(Icons.person, color:controller.isProfileScreen.value? AppColors.backgroundColor: Colors.black,),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
