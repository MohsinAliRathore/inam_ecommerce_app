import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inam_ecomerce_app/Screens/MainScreen.dart';
import 'package:inam_ecomerce_app/Screens/OTPVerification.dart';
import 'package:inam_ecomerce_app/Screens/RegisterScreen.dart';
import 'package:inam_ecomerce_app/Utils/Urls.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  static UserController? _instance;

  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String otpCode="";
  late String? name, address, token;
  var localStorage = GetStorage();
  RxBool isLoading = true.obs;


  static UserController get instance {
    _instance ??= UserController();
    return _instance!;
  }


  void getOtp() async{
    try {
      isLoading.value = true;
      final response =await http.post(Uri.parse(Urls.getOtp),
          headers: {"Accept": "application/json"},
          body: ({
            "number": numberController.text
          })
      ).timeout(Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },);
      print(response.body);
      if(response.statusCode == 200){
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "OTP sent to your number",
          toastLength: Toast.LENGTH_LONG
        );
        Get.off(OTPVerification());
      }
      else if(response.statusCode == 400){
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Some error occured please try again",
            toastLength: Toast.LENGTH_LONG
        );
      }
      else if(response.statusCode == 500){
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Server is not responding. Try after some time",
            toastLength: Toast.LENGTH_LONG
        );
      }
      else{
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Some error occured please try again",
            toastLength: Toast.LENGTH_LONG
        );
      }
    }catch (e) {
      if (e is TimeoutException) {
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Unstable internet connection.",
            toastLength: Toast.LENGTH_LONG
        );

      } else {
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Some error occured please try again",
            toastLength: Toast.LENGTH_LONG
        );

        print('Error: $e');
      }

    }
  }

  void verifyOtp() async{
    try {
      //isApiLoading.value = true;
      isLoading.value=true;
      final response =await http.post(Uri.parse(Urls.verifyOtp),
          headers: {"Accept": "application/json"},
          body: ({
            "number": numberController.text,
            "otp": otpCode
          })
      ).timeout(Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },);
      print(otpCode);
      print(response.body);
      print(response.statusCode);
      if(response.statusCode == 200) {
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "OTP verified",
            toastLength: Toast.LENGTH_LONG
        );
        var decodedResponse = jsonDecode(response.body);
        name = decodedResponse["data"]["name"];
        token = decodedResponse["data"]["token"];
        localStorage.write("token", token);
        if (name == null || name == "null") {
          Get.to(() => RegisterScreen());
        } else {
          Get.off(() => MainScreen());
        }
        //Get.off(OTPVerification());
      }
      else if(response.statusCode==201){
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "OTP verified",
            toastLength: Toast.LENGTH_LONG
        );
        var decodedResponse = jsonDecode(response.body);
        name = decodedResponse["data"]["name"];
        token = decodedResponse["data"]["token"];
        localStorage.write("token", token);
        if(name ==null || name=="null"){
          Get.to(()=> RegisterScreen());
        }else{
          Get.off(()=> MainScreen());
        }
      }
      else if(response.statusCode == 400){
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Some error occured please try again",
            toastLength: Toast.LENGTH_LONG
        );
      }
      else if(response.statusCode == 500){
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Server is not responding. Try after some time",
            toastLength: Toast.LENGTH_LONG
        );
      }
      else{
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Some error occured please try again",
            toastLength: Toast.LENGTH_LONG
        );
      }
    }catch (e) {
      if (e is TimeoutException) {
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Unstable internet connection.",
            toastLength: Toast.LENGTH_LONG
        );

      } else {
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Some error occured please try again",
            toastLength: Toast.LENGTH_LONG
        );

        print('Error: $e');
      }
    }
  }

  void registerUser() async{
    try {
      isLoading.value=true;
      final response =await http.post(Uri.parse(Urls.updateUser),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          body: ({
            "address": addressController.text,
            "name": nameController.text,
            "email": emailController.text,
            "password": passwordController.text,
          })
      ).timeout(Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },);
      print(otpCode);
      print(response.body);
      print(response.statusCode);
      if(response.statusCode == 200){
        Fluttertoast.showToast(
            msg: "Registered Successfully",
            toastLength: Toast.LENGTH_LONG
        );

        Get.off(MainScreen());
      }
      else if(response.statusCode == 400){
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Some error occured please try again",
            toastLength: Toast.LENGTH_LONG
        );
      }
      else if(response.statusCode == 500){
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Server is not responding. Try after some time",
            toastLength: Toast.LENGTH_LONG
        );
      }
      else{
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Some error occured please try again",
            toastLength: Toast.LENGTH_LONG
        );
      }
    }catch (e) {
      if (e is TimeoutException) {
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Unstable internet connection.",
            toastLength: Toast.LENGTH_LONG
        );

      } else {
        isLoading.value=false;
        Fluttertoast.showToast(
            msg: "Some error occured please try again",
            toastLength: Toast.LENGTH_LONG
        );

        print('Error: $e');
      }

    }
  }
}