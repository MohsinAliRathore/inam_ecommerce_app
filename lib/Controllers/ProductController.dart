import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inam_ecomerce_app/Utils/Urls.dart';
import 'dart:convert';

import '../Models/ProductsModel.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  static RxMap cartItems = {}.obs;

  static void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
  }

  static double getTotalPrice() {
    double totalPrice = 0;
    cartItems.forEach((product, quantity) {
      totalPrice += double.parse(product.price) * quantity;
    });
    return totalPrice;
  }

  static void removeItem(Product product) {
    cartItems.remove(product);
  }

  static void increaseQuantity(Product product) {
    cartItems[product] = (cartItems[product] ?? 0) + 1;
  }

  static void decreaseQuantity(Product product) {
    if (cartItems[product] == 1) {
      removeItem(product);
    } else {
      cartItems[product] = cartItems[product]! - 1;
    }
  }

  void fetchProducts(int index) async {
    var url = Uri.parse('${Urls.productByCategory}$index');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Product> productList = [];
      for (var item in jsonData['data']) {
        productList.add(Product.fromJson(item));
      }
      products.value = productList;
    } else {
      print('Failed to load products');
    }
  }
}