
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';
import 'package:inam_ecomerce_app/Controllers/ProductController.dart';
import 'package:inam_ecomerce_app/Views/ProductCard.dart';

class ProductScreen extends StatelessWidget {
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.backgroundColor,
          title: Text('Products', style: TextStyle(color:Colors.white),),
        ),
        body: Obx(() {
          if(productController.isLoading.value == true){
            return const Center(child: CircularProgressIndicator());
          }
          else if (productController.products.isEmpty) {
            return const Center(child: Text("No products available in this Category"));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: productController.products[index]);
              },
            );
          }
        })
    );
  }
}