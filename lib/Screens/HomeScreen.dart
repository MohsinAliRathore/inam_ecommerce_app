import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inam_ecomerce_app/Controllers/ProductController.dart';
import 'package:inam_ecomerce_app/Screens/ProductScreens.dart';

import '../Controllers/CategoryController.dart';
import '../Views/CategoryCard.dart';

class HomeScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Screen'),
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: categoryController.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: CategoryCard(category: categoryController.categories[index]),
                onTap: (){
                    print(categoryController.categories[index].id);
                    productController.fetchProducts(categoryController.categories[index].id);
                    Get.to(ProductScreen());
                },
              );
            },
          );
        }
      }),
    );
  }
}
