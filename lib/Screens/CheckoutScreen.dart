import 'package:flutter/material.dart';

import '../Controllers/ProductController.dart';
import '../Models/ProductsModel.dart';


class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: ListView.builder(
        itemCount: ProductController.cartItems.length,
        itemBuilder: (context, index) {
          Product product = ProductController.cartItems[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Price: ${product.price}'),
            trailing: Text('Quantity: 1'),
          );
        },
      ),
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
