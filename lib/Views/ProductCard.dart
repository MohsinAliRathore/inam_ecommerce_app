// Import required packages
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../AppTheme/AppColors.dart';
import '../Controllers/ProductController.dart';
import '../DataBase/DataBaseHelper.dart';
import '../Models/ProductsModel.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final ProductController productController = Get.find();

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: widget.product.bulkPriceAvailable? 5:4,
                child: Image.network(
                    'https://inamstore.devblinks.com/storage/${widget.product.image}'),
              ),
              Expanded(
                flex:widget.product.bulkPriceAvailable? 6:3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14)),
                      Text('Rs ${widget.product.price}', style: TextStyle(fontSize: 12),),
                      widget.product.bulkPriceAvailable?
                      Text("Bulk price ${widget.product.bulkQty}x @${widget.product.bulkPrice}",
                      style: TextStyle(fontSize: 12, color: AppColors.backgroundColor),): SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Show + icon if quantity is 0 or database is not available
          if (quantityInDb == 0)
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () async {
                  await dbHelper.insertProduct(widget.product.id, 1);
                  _checkQuantityInDb();
                  Fluttertoast.showToast(msg: "Item added to cart");
                  widget.productController.addToCart(widget.product);
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

          // Show quantity with + and - icons if quantity is greater than 0
          if (quantityInDb > 0)
            Align(
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
                      onTap: () async {
                        if (quantityInDb > 1) {
                          await dbHelper.updateProduct(
                              widget.product.id, quantityInDb - 1);
                          widget.productController.decreaseQuantity(widget.product);
                          _checkQuantityInDb();
                        } else {
                          await dbHelper.deleteProduct(widget.product.id);
                          widget.productController.removeItem(widget.product);
                          _checkQuantityInDb();
                        }
                        Fluttertoast.showToast(msg: "Quantity updated");
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Icon(
                            quantityInDb>1? Icons.remove: Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: AppColors.backgroundColor,
                      child: Text(
                        '$quantityInDb',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await dbHelper.updateProduct(
                            widget.product.id, quantityInDb + 1);
                        _checkQuantityInDb();
                        widget.productController.addToCart(widget.product);
                        //widget.productController.increaseQuantity(widget.product);
                        Fluttertoast.showToast(msg: "Quantity updated");
                      },
                      child: Container(
                        height: 30,
                        width: 30,
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
            ),
        ],
      ),
    );
  }
}
