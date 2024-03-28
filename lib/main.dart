import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inam_ecomerce_app/Controllers/CategoryController.dart';
import 'package:inam_ecomerce_app/Controllers/HomeController.dart';
import 'package:inam_ecomerce_app/Controllers/ProductController.dart';
import 'package:inam_ecomerce_app/Controllers/UserController.dart';
import 'package:inam_ecomerce_app/Screens/SplashScreen.dart';

import 'DataBase/DataBaseHelper.dart';

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
  if(isLogin =="yes"){
    userController.isLogin.value=true;
  }
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final dbHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      dbHelper.deleteDB();
    }
  }
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
