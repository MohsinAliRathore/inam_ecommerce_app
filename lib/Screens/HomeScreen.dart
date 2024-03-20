import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';
import 'package:inam_ecomerce_app/Controllers/ProductController.dart';
import 'package:inam_ecomerce_app/Controllers/UserController.dart';
import 'package:inam_ecomerce_app/Screens/NumberVerification.dart';
import 'package:inam_ecomerce_app/Screens/ProductScreens.dart';

import '../Controllers/CategoryController.dart';
import '../Controllers/HomeController.dart';
import '../Validators/InternetValidator.dart';
import '../Views/CategoryCard.dart';

class HomeScreen extends StatelessWidget {
  final CategoryController categoryController = Get.find();
  final HomeController homeController = Get.find();

  final UserController userController = Get.find();

  final ProductController productController = Get.find();

  InternetValidator internetValidator = InternetValidator();

  late RxBool isInternetAvailable =false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Text('Categories', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Obx(()=>Container(
            child: userController.isLogin.value?SizedBox():Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                    color: Colors.black,
                  )
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex:3,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Log in or Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),
                              ),
                              Text("Log in to place an order",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex:2,
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: (){
                              homeController.isHomeScreen.value = false;
                              homeController.isCheckOutScreen.value = false;
                              homeController.isProfileScreen.value = false;
                              homeController.isProductScreen.value = false;
                              homeController.isNumberVerificationScreen.value = true;
                              homeController.isOrderListScreen.value = false;
                              homeController.isOTPVerificationScreen.value = false;
                              homeController.isRegisterScreen.value=false;
                            },
                            child: Text("Let's Go"),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),),

          Obx(() {
            if (categoryController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if(categoryController.categories.isEmpty){
              return Center(child: Text("No Categories Available"),);
            }
            else{
              return categoryController.isInternetAvailable.value? Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: categoryController.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        child: CategoryCard(category: categoryController.categories[index]),
                      onTap: () async{
                        isInternetAvailable.value = await InternetValidator.isInternetAvailable();
                        if(isInternetAvailable.value==true){
                          print(categoryController.categories[index].id);
                          productController.fetchProducts(categoryController.categories[index].id);
                          homeController.isHomeScreen.value = false;
                          homeController.isCheckOutScreen.value = false;
                          homeController.isProfileScreen.value = false;
                          homeController.isProductScreen.value = true;
                          homeController.isNumberVerificationScreen.value = false;
                          homeController.isRegisterScreen.value=false;
                          homeController.isOrderListScreen.value = false;
                          homeController.isOTPVerificationScreen.value = false;
                        }else{
                          Fluttertoast.showToast(
                              msg: "You don't have a internet connection.",
                              toastLength: Toast.LENGTH_LONG
                          );
                        }
                      },
                    );
                  },
                ),
              )
                  : Center(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                        width: 50,
                        child: Icon(Icons.signal_wifi_connected_no_internet_4_sharp,color: AppColors.backgroundColor,)),
                    Text("No Internet Available",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.backgroundColor
                    ),)
                  ],
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
