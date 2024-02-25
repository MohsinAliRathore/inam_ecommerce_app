import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inam_ecomerce_app/Screens/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
