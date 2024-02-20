import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inam_ecomerce_app/Utils/Urls.dart';
import 'dart:convert';

import '../Models/CategoryModel.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categories = <Datum>[].obs;
  var products = <Datum>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse(Urls.categoryList));
      if (response.statusCode == 200) {
        Categories categoryData = categoriesFromJson(response.body);
        categories.assignAll(categoryData.data);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductsFromCategory(int index) async {
    try {
      var response = await http.get(Uri.parse('${Urls.productByCategory}$index'));
      if (response.statusCode == 200) {
        Categories categoryData = categoriesFromJson(response.body);
        // categories.assignAll(categoryData.data);
        print(response.body);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
