import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';

import '../Controllers/ProductController.dart';
import '../Models/ProductsModel.dart';

class CheckoutPage extends StatelessWidget {
  final ProductController productController = ProductController.instance;

  @override
  Widget build(BuildContext context) {
    var localStorage = GetStorage();
    late var userAddress;
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: ProductController.cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty.'),
            )
          : Column(
              children: [
                Obx(() => Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: ProductController.cartItems.length,
                        itemBuilder: (context, index) {
                          Product product =
                              ProductController.cartItems.keys.toList()[index];
                          int quantity = ProductController.cartItems.values
                              .toList()[index];
                          return ListTile(
                            title: Text(product.name),
                            subtitle: Text('Base Price: ${product.price}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    ProductController.decreaseQuantity(product);
                                  },
                                ),
                                Text('$quantity'),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    ProductController.increaseQuantity(product);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    ProductController.removeItem(product);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )),
                SizedBox(
                  child: Obx(
                    () => productController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.backgroundColor,
                          ))
                        : ElevatedButton(
                            onPressed: () async {
                              userAddress = localStorage.read("address");
                              productController.isLoading.value = true;
                              String token = localStorage.read("token");
                              print(token);
                              List<Product> products = ProductController
                                  .cartItems.keys
                                  .cast<Product>()
                                  .toList();
                              await ProductController.createOrder(
                                  token, products, userAddress);
                              productController.isLoading.value = false;
                            },
                            child: Text('Place Order'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: AppColors
                                      .backgroundColor, // Set the border color
                                  width: 1.0, // Set the border width
                                ),
                              ),
                            ),
                          ),
                  ),
                )
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Total Price: Rs ${ProductController.getTotalPrice().toInt()}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
