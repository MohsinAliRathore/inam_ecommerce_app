import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../AppTheme/AppColors.dart';
import '../Controllers/ProductController.dart';
import '../Models/ProductsModel.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ProductController productController = Get.find();
  int quantity = 0;

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
                          'https://inamstore.devblinks.com/storage/${widget.product.image}'),
                    ),
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
                            child: Text(widget.product.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('Rs ${widget.product.price}'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            productController.cartItems.containsKey(widget.product) || widget.product.quantity > 0
                ? Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (widget.product.quantity > 1) {
                            widget.product.quantity--;
                          } else {
                            productController.removeItem(widget.product);
                            widget.product.quantity = 0;
                          }
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        //margin: EdgeInsets.only(top: 20, right: 5),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Icon(
                            widget.product.quantity > 1 ? Icons.remove : Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: AppColors.backgroundColor,
                      child: Text(
                        '${widget.product.quantity}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.product.quantity++;
                          productController.addToCart(widget.product);
                          Fluttertoast.showToast(msg: "Item added to cart");
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        //margin: EdgeInsets.only(top: 20, right: 5),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.product.quantity++;
                    productController.addToCart(widget.product);
                    Fluttertoast.showToast(msg: "Item added to cart");
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(top: 15, right: 5),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
