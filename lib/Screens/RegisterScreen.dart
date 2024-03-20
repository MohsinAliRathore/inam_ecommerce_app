import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:inam_ecomerce_app/Controllers/UserController.dart';
import 'package:inam_ecomerce_app/Widgets/CustomTextField.dart';

import '../AppTheme/AppColors.dart';
import '../Validators/InternetValidator.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Registration',
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
                    controller: userController.nameController,
                    title: "Name",
                    hint: "Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      if (RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'Only alphabets are allowed';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    controller: userController.emailController,
                    title: "Email",
                    hint: "email@gmail.com",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'Invalid email address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    controller: userController.passwordController,
                    title: "Password",
                    hint: "Password",
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 8) {
                        return 'Minimum 8 characters';
                      }
                      if (RegExp(r'^\d{1,11}$').hasMatch(value)) {
                        return 'Maximum 11 numbers are allowed';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    controller: userController.addressController,
                    title: "Address",
                    hint: "Address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }
                    },
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
                                    userController.registerUser();
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
