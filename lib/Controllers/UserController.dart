import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inam_ecomerce_app/Controllers/HomeController.dart';
import 'package:inam_ecomerce_app/Utils/Urls.dart';
import 'package:http/http.dart' as http;

import '../Models/OrdersModel.dart';

class UserController extends GetxController {
  static UserController? _instance;

  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final HomeController homeController = Get.find();
  String otpCode="";
  late String? name, address, token, MyLoginKey;
  var localStorage = GetStorage();
  RxBool isLoading = false.obs;
  RxBool isLogin = false.obs;
  RxBool isFromCart = false.obs;
  var ordersList = <Datum>[].obs;



  static UserController get instance {
    _instance ??= UserController();
    return _instance!;
  }


  void getOtp() async{
    if(numberController.text.isNotEmpty){
      if(numberController.text.length == 11){
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
            homeController.isHomeScreen.value = false;
            homeController.isCheckOutScreen.value = false;
            homeController.isProfileScreen.value = false;
            homeController.isProductScreen.value = false;
            homeController.isNumberVerificationScreen.value = false;
            homeController.isOrderListScreen.value = false;
            homeController.isOTPVerificationScreen.value = true;
            homeController.isRegisterScreen.value=false;
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
      }else{
        Fluttertoast.showToast(
            msg: "Length of number should be 11",
            toastLength: Toast.LENGTH_LONG
        );
      }

    }else{
      Fluttertoast.showToast(
          msg: "Please enter number",
          toastLength: Toast.LENGTH_LONG
      );
    }
  }

  void verifyOtp() async{
    if(otpCode.isNotEmpty){
      if(otpCode.length>5){
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
            address = decodedResponse["data"]["address"];
              MyLoginKey ="yes";
              localStorage.write("token", token);
              localStorage.write("address", address);
              localStorage.write("isLogin", MyLoginKey);
              localStorage.write("name", name);
              if(isFromCart.value == true){
                homeController.isHomeScreen.value = false;
                homeController.isCheckOutScreen.value = true;
                homeController.isProfileScreen.value = false;
                homeController.isProductScreen.value = false;
                homeController.isNumberVerificationScreen.value = false;
                homeController.isOrderListScreen.value = false;
                homeController.isOTPVerificationScreen.value = false;
                homeController.isRegisterScreen.value=false;
                isLogin.value=true;
              }
              else{
                homeController.isHomeScreen.value = true;
                homeController.isCheckOutScreen.value = false;
                homeController.isProfileScreen.value = false;
                homeController.isProductScreen.value = false;
                homeController.isNumberVerificationScreen.value = false;
                homeController.isOrderListScreen.value = false;
                homeController.isOTPVerificationScreen.value = false;
                homeController.isRegisterScreen.value=false;
                isLogin.value=true;
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
            //name = decodedResponse["data"]["name"];
            token = decodedResponse["data"]["token"];
            //address = decodedResponse["data"]["address"];

              MyLoginKey ="yes";
              localStorage.write("token", token);
              //localStorage.write("address", address);
              localStorage.write("isLogin", MyLoginKey);
              homeController.isHomeScreen.value = false;
              homeController.isCheckOutScreen.value = false;
              homeController.isProfileScreen.value = false;
              homeController.isProductScreen.value = false;
              homeController.isNumberVerificationScreen.value = false;
              homeController.isOrderListScreen.value = false;
              homeController.isOTPVerificationScreen.value = false;
              homeController.isRegisterScreen.value=true;

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
      }else{
        Fluttertoast.showToast(
            msg: "Please enter complete OTP",
            toastLength: Toast.LENGTH_LONG
        );
      }
    }
    else{
      Fluttertoast.showToast(
          msg: "Please enter OTP",
          toastLength: Toast.LENGTH_LONG
      );
    }

  }

  void registerUser() async{
    if(addressController.text.isNotEmpty && nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
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
        if(response.statusCode == 200){
          print(response.body);
          Fluttertoast.showToast(
              msg: "Registered Successfully",
              toastLength: Toast.LENGTH_LONG
          );
          MyLoginKey ="yes";
          localStorage.write("isLogin", MyLoginKey);
          localStorage.write("address", addressController.text);
          localStorage.write("name", nameController.text);
          isLogin.value=true;
          isLoading.value=false;
          if(isFromCart.value==true){
            homeController.isHomeScreen.value = false;
            homeController.isCheckOutScreen.value = true;
            homeController.isProfileScreen.value = false;
            homeController.isProductScreen.value = false;
            homeController.isNumberVerificationScreen.value = false;
            homeController.isOrderListScreen.value = false;
            homeController.isOTPVerificationScreen.value = false;
            homeController.isRegisterScreen.value=false;
          }else{
            homeController.isHomeScreen.value = true;
            homeController.isCheckOutScreen.value = false;
            homeController.isProfileScreen.value = false;
            homeController.isProductScreen.value = false;
            homeController.isNumberVerificationScreen.value = false;
            homeController.isOrderListScreen.value = false;
            homeController.isOTPVerificationScreen.value = false;
            homeController.isRegisterScreen.value=false;
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

        }
        else {
          isLoading.value=false;
          Fluttertoast.showToast(
              msg: "Some error occured please try again",
              toastLength: Toast.LENGTH_LONG
          );

          print('Error: $e');
        }

      }
    }else{
      Fluttertoast.showToast(
          msg: "Please fill all fields",
          toastLength: Toast.LENGTH_LONG
      );
    }

  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      String? token = await localStorage.read("token");
      final response = await http.get(Uri.parse(Urls.ordersByUser), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      }).timeout(const Duration(seconds: 30), onTimeout: () {
        throw TimeoutException('Request timed out');
      });
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        isLoading.value=false;
        var responseData = jsonDecode(response.body);
        List<Datum> fetchedOrders = List<Datum>.from(responseData['data'].map((x) => Datum.fromJson(x)));
        if(fetchedOrders.isNotEmpty){
          ordersList.assignAll(fetchedOrders);
          homeController.isHomeScreen.value = false;
          homeController.isCheckOutScreen.value = false;
          homeController.isProfileScreen.value = false;
          homeController.isProductScreen.value = false;
          homeController.isNumberVerificationScreen.value = false;
          homeController.isOrderListScreen.value = true;
          homeController.isOTPVerificationScreen.value = false;
          homeController.isRegisterScreen.value=false;
        }else{
          Fluttertoast.showToast(msg: "You have not placed a order yet",
            toastLength: Toast.LENGTH_LONG
          );
        }

      } else {
        isLoading.value=false;
        _handleError(response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  void _handleError(dynamic e) {
    isLoading.value = false;
    if (e is TimeoutException) {
      Fluttertoast.showToast(
          msg: "Unstable internet connection.",
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: "Some error occurred please try again",
          toastLength: Toast.LENGTH_LONG);
      print('Error: $e');
    }
  }
}