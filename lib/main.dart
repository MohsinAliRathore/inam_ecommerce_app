import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inam_ecomerce_app/Controllers/CategoryController.dart';
import 'package:inam_ecomerce_app/Controllers/HomeController.dart';
import 'package:inam_ecomerce_app/Controllers/ProductController.dart';
import 'package:inam_ecomerce_app/Controllers/UserController.dart';
import 'package:inam_ecomerce_app/Screens/SplashScreen.dart';

void main() async{
  Get.put(HomeController(), permanent: true);
  Get.put(CategoryController(), permanent: true);
  Get.put(UserController(), permanent: true);
  Get.put(ProductController(), permanent: true);
  await GetStorage.init();
  final UserController userController = Get.find();
  var localStorage = GetStorage();
  localStorage.erase();
  String? isLogin =await  localStorage.read("isLogin");
  print("islogin call"+isLogin.toString());
  if(isLogin =="yes"){
    userController.isLogin.value=true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
