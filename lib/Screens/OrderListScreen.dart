import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';
import 'package:inam_ecomerce_app/Controllers/UserController.dart';

import '../Views/OrderCard.dart';


class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Text('Orders List', style: TextStyle(color: Colors.white),),
      ),
      body: GetX<UserController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: controller.ordersList.length,
            itemBuilder: (context, index) {
              return OrderCard(order: controller.ordersList[index]);
            },
          );
        },
      ),
    );
  }
}
