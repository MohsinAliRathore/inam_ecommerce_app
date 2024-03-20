import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../AppTheme/AppColors.dart';
import '../Controllers/UserController.dart';
import '../Validators/InternetValidator.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'OTP Verification',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset("Assets/Images/LOGO.png"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Enter OTP",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: AppColors.backgroundColor,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    userController.otpCode = verificationCode;
                  }, // end onSubmit
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
                                    userController.verifyOtp();
                                  }else{
                                    Fluttertoast.showToast(
                                        msg: "No Internet Available. Try Again",
                                        toastLength: Toast.LENGTH_LONG
                                    );
                                  }
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
