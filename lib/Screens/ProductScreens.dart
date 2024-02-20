import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inam_ecomerce_app/Controllers/ProductController.dart';
import 'package:inam_ecomerce_app/Views/ProductCard.dart';

import '../Controllers/CategoryController.dart';

class ProductScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Obx(() {
        if (productController.products.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
