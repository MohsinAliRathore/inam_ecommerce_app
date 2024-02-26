import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';
import 'package:inam_ecomerce_app/Controllers/ProductController.dart';
import 'package:inam_ecomerce_app/Screens/NumberVerification.dart';
import 'package:inam_ecomerce_app/Screens/ProductScreens.dart';

import '../Controllers/CategoryController.dart';
import '../Validators/InternetValidator.dart';
import '../Views/CategoryCard.dart';

class HomeScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());
  InternetValidator internetValidator = InternetValidator();
  late RxBool isInternetAvailable =false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text('Categories', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Container(
            height: 75,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    flex:1,
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        height: 100,
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
                    flex:1,
                      child: Container(
                        padding: EdgeInsets.only(right: 30),
                        child: ElevatedButton(
                          onPressed: (){
                            Get.off(NumberVerification());
                          },
                          child: Text("Let's Go"),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Obx(() {
            if (categoryController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if(categoryController.categories.isEmpty){
              return Center(child: Text("No Categories Available"),);
            }
            else{
              return Expanded(
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
                          Get.to(ProductScreen());
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
              );
            }
          }),
        ],
      ),
    );
  }
}
