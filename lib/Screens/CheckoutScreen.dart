import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';
import 'package:inam_ecomerce_app/Controllers/HomeController.dart';
import 'package:inam_ecomerce_app/Controllers/UserController.dart';
import 'package:inam_ecomerce_app/Screens/NumberVerification.dart';
import 'package:inam_ecomerce_app/Widgets/CustomTextField.dart';

import '../Controllers/ProductController.dart';
import '../DataBase/DataBaseHelper.dart';
import '../Models/ProductsModel.dart';
import '../Validators/InternetValidator.dart';
import '../Views/CartItem.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final ProductController productController = Get.find();

  final HomeController homeController = Get.find();

  final UserController userController = Get.find();



  @override
  Widget build(BuildContext context) {
    var localStorage = GetStorage();
    late var userAddress;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Text('Checkout', style: TextStyle(color: Colors.white),),
      ),
      body: productController.cartItems.isEmpty
          ? const Center(
        child: Text('Your cart is empty.'),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => Container(
              height: 340,
              child: ListView.builder(
                itemCount: productController.cartItems.length,
                itemBuilder: (context, index) {
                  Product product =
                  productController.cartItems.keys.toList()[index];
                  return CartItem(product: product, productController: productController);
                },
              ),
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal:20, vertical: 10),
              child: Obx(
                    () => productController.isLoading.value
                    ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.backgroundColor,
                    ))
                    : productController.cartItems.isEmpty? const SizedBox(child: Center(
                  child: Text('Your cart is empty.'),
                ),): Column(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: CustomTextField(
                          hint: "Delivery Address",
                          title: "Add Delivery Address",
                          controller: productController.deliveryAddressController,
                          validator:  (value) {
                            if (value == null || value.isEmpty) {
                              return 'Address is required';
                            }
                          },
                        )),
                    ElevatedButton(
                      onPressed: () async {
                        bool isInternetAvailable = await InternetValidator.isInternetAvailable();
                        if(isInternetAvailable==true){
                          String? token = localStorage.read("token");
                          userAddress = localStorage.read("address");
                          //print(token);
                          //print(userAddress);
                          if(token!=null && userAddress!=null){
                            if(productController.deliveryAddressController.text.isNotEmpty){
                              productController.isLoading.value = true;
                              print(token);
                              List<Product> products = productController
                                  .cartItems.keys
                                  .cast<Product>()
                                  .toList();
                              await productController.createOrder(
                                  token, products);
                              productController.isLoading.value = false;
                              userController.isFromCart.value=false;
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Please enter delivery address",
                                  toastLength: Toast.LENGTH_SHORT
                              );
                            }

                          }
                          else{
                            userController.isFromCart.value=true;
                            Fluttertoast.showToast(msg: "You need to login first to place order");
                            homeController.isHomeScreen.value = false;
                            homeController.isCheckOutScreen.value = false;
                            homeController.isProfileScreen.value = false;
                            homeController.isProductScreen.value = false;
                            homeController.isNumberVerificationScreen.value = true;
                            homeController.isOrderListScreen.value = false;
                            homeController.isOTPVerificationScreen.value = false;
                            homeController.isRegisterScreen.value=false;
                          }
                        }else{
                          Fluttertoast.showToast(
                              msg: "No Internet Available. Try Again",
                              toastLength: Toast.LENGTH_LONG
                          );
                        }


                      },
                      child: Text('Place Order', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: AppColors
                                .backgroundColor, // Set the border color
                            width: 1.0, // Set the border width
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Obx(()=>
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: productController.cartItems.isEmpty?
            const SizedBox():
            productController.cartItems==null && productController.cartItems.length==0 && productController.orderDone.value?
            SizedBox()
                : Text(
              'Total Price: Rs ${productController.getTotalPrice().toInt()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
      ),
    );
  }
}

