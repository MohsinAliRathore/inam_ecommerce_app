import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';
import 'package:inam_ecomerce_app/Screens/MainScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.white,
        onInit: () {
        },
        onEnd: () {
        },
        childWidget: SizedBox(
          height: 250,
          width: 250,
          child: Image.asset("Assets/Images/LOGO.png"),
        ),
        animationDuration: Duration(seconds: 3),
        duration: Duration(seconds: 3),
        nextScreen: const MainScreen(),
      )
    );
  }
}
