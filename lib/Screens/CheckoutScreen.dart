import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/ProductController.dart';
import '../Models/ProductsModel.dart';


class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: ProductController.cartItems.isEmpty
          ? Center(
        child: Text('Your cart is empty.'),
      )
          : Obx(()=>ListView.builder(
        itemCount: ProductController.cartItems.length,
        itemBuilder: (context, index) {
          Product product = ProductController.cartItems.keys.toList()[index];
          int quantity = ProductController.cartItems.values.toList()[index];
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
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Total Price: Rs ${ProductController.getTotalPrice()}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
