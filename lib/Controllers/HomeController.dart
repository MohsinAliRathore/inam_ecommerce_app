import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;
  RxBool isHomeScreen = true.obs;
  RxBool isCheckOutScreen = false.obs;
  RxBool isProfileScreen = false.obs;
  RxBool isProductScreen = false.obs;
  RxBool isNumberVerificationScreen = false.obs;
  RxBool isOrderListScreen = false.obs;
  RxBool isOTPVerificationScreen = false.obs;
  RxBool isRegisterScreen = false.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}