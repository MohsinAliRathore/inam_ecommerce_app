import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inam_ecomerce_app/Utils/Urls.dart';
import 'dart:convert';

import '../Models/ProductsModel.dart';

class ProductController extends GetxController {
  static ProductController? _instance;

  var products = <Product>[].obs;
  static RxMap cartItems = {}.obs;
  RxBool isLoading = false.obs;

  static ProductController get instance {
    _instance ??= ProductController();
    return _instance!;
  }

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

  static Future<void> createOrder(String token, List<Product> products, String userAddress) async {
    double totalPrice = getTotalPrice();
    int totalQuantity = cartItems.values.reduce((a, b) => a + b);

    List<Map<String, dynamic>> orderDetails = [];
    products.forEach((product) {
      orderDetails.add({
        "product_name": product.name,
        "product_price": double.parse(product.price),
        "product_qty": cartItems[product],
        "total": double.parse(product.price) * cartItems[product]!,
      });
    });

    Map<String, dynamic> requestBody = {
      "total": totalPrice,
      "qty": totalQuantity,
      "delivery_fee": 50,
      "address": userAddress,
      "order_details": orderDetails,
    };

    try {
      final response = await http.post(
        Uri.parse(Urls.createOrder),
        headers:{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(requestBody)
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Your order is placed successfully",
            toastLength: Toast.LENGTH_LONG
        );
        cartItems.clear();

      } else {
        print("error body: ${response.body}");
        print(response.statusCode);
      }
    } catch (e) {
      print("Error creating order: $e");
    }
  }

  void fetchProducts(int index) async {
    isLoading.value=true;
    var url = Uri.parse('${Urls.productByCategory}$index');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      isLoading.value =false;
      var jsonData = json.decode(response.body);
      List<Product> productList = [];
      for (var item in jsonData['data']) {
        productList.add(Product.fromJson(item));
      }
      products.value = productList;
    } else {
      isLoading.value=false;
      print('Failed to load products');
    }
  }
}