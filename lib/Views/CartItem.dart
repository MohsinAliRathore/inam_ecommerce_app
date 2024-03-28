import 'package:flutter/material.dart';

import '../Controllers/ProductController.dart';
import '../DataBase/DataBaseHelper.dart';
import '../Models/ProductsModel.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.product, required  this.productController,
  });

  final Product product;
  final ProductController productController;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final dbHelper = DatabaseHelper();
  int quantityInDb = 0;

  @override
  void initState() {
    super.initState();
    _checkQuantityInDb();
  }

  // Check quantity of the product in the database
  void _checkQuantityInDb() async {
    int quantity = await dbHelper.getProductQuantity(widget.product.id);
    setState(() {
      quantityInDb = quantity;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
          child: Image.network('https://inamstore.devblinks.com/storage/${widget.product.image}')),
      title: Text(widget.product.name),
      subtitle: Text('Base Price: ${widget.product.bulkPriceAvailable && quantityInDb>=int.parse(widget.product.bulkQty!)? widget.product.bulkPrice : widget.product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () async{
              if (quantityInDb > 1) {
                await dbHelper.updateProduct(
                    widget.product.id, quantityInDb - 1);
                widget.productController.decreaseQuantity(widget.product);
                _checkQuantityInDb();
              } else {
                await dbHelper.deleteProduct(widget.product.id);
                widget.productController.removeItem(widget.product);
              }
              //productController.decreaseQuantity(product);
            },
          ),
          Text('$quantityInDb'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async{
              await dbHelper.updateProduct(
                  widget.product.id, quantityInDb + 1);
              _checkQuantityInDb();
              widget.productController.addToCart(widget.product);
              //productController.increaseQuantity(product);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              await dbHelper.deleteProduct(widget.product.id);
              widget.productController.removeItem(widget.product);
              _checkQuantityInDb();
            },
          ),
        ],
      ),
    );
  }
}