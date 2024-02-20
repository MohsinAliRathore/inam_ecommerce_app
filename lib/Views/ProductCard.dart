import 'package:flutter/material.dart';
import '../Controllers/ProductController.dart';
import '../Models/ProductsModel.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                        height: 100,
                        child: Image.network(
                            'https://inamstore.devblinks.com/storage/${product.image}')),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(product.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(product.price),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  ProductController.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added to cart')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
