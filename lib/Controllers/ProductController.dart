import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inam_ecomerce_app/Utils/Urls.dart';
import 'dart:convert';

import '../Models/ProductsModel.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  static List<Product> cartItems = [];

  @override
  void onInit() {
    super.onInit();
  }


  static void addToCart(Product product) {
    cartItems.add(product);
  }

  static double getTotalPrice() {
    double totalPrice = 0;
    for (Product product in cartItems) {
      totalPrice += double.parse(product.price);
    }
    return totalPrice;
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
