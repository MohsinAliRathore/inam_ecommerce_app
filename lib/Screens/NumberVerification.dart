import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inam_ecomerce_app/Screens/OTPVerification.dart';
import 'package:inam_ecomerce_app/Widgets/CustomTextField.dart';

import '../AppTheme/AppColors.dart';

class NumberVerification extends StatelessWidget {
  const NumberVerification({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text('Number Verification', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset("Assets/Images/LOGO.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomTextField(controller: controller, label: "Phone Number", hint: "+9230013456789",),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: Get.size.width,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: (){
                        Get.off(OTPVerification());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: AppColors.backgroundColor, // Set the border color
                            width: 1.0, // Set the border width
                          ),
                        ),
                      ),
                      child: Text(
                        "Continue",
                        style:  TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
