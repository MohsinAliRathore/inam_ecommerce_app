import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:inam_ecomerce_app/Controllers/UserController.dart';
import 'package:inam_ecomerce_app/Screens/OTPVerification.dart';
import 'package:inam_ecomerce_app/Widgets/CustomTextField.dart';

import '../AppTheme/AppColors.dart';
import '../Validators/InternetValidator.dart';

class NumberVerification extends StatelessWidget {
  const NumberVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Number Verification',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                  child: CustomTextField(
                    controller: userController.numberController,
                    title: "Phone Number",
                    hint: "030013456789",
                    inputFormatter: FilteringTextInputFormatter.digitsOnly,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(
                      () => SizedBox(
                        width: Get.size.width,
                        height: 48,
                        child: userController.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: () async {
                                  bool isInternetAvailable =
                                      await InternetValidator
                                          .isInternetAvailable();
                                  if (isInternetAvailable == true) {
                                    userController.getOtp();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "No Internet Available. Try Again",
                                        toastLength: Toast.LENGTH_LONG);
                                  }
                                  //Get.off(OTPVerification());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.backgroundColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                      color: AppColors.backgroundColor,
                                      // Set the border color
                                      width: 1.0, // Set the border width
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
