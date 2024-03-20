import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inam_ecomerce_app/Utils/Urls.dart';
import 'dart:convert';

import '../Models/CategoryModel.dart';
import '../Validators/InternetValidator.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categories = <Datum>[].obs;
  var products = <Datum>[].obs;
  InternetValidator internetValidator = InternetValidator();
  late RxBool isInternetAvailable =false.obs;

  @override
  void onInit() {
    super.onInit();
    checkInternetAndGetProducts();
  }

  checkInternetAndGetProducts() async {
    isInternetAvailable.value = await InternetValidator.isInternetAvailable();
    if(isInternetAvailable.value ==true){
      print("fetch called");
      fetchData();
    }else{
      Fluttertoast.showToast(
          msg: "You don't have a internet connection.",
          toastLength: Toast.LENGTH_LONG
      );
    }
  }

  Future<void> fetchData() async {
    try {
      isLoading.value= true;
      var response = await http.get(Uri.parse(Urls.categoryList),headers: {"Accept": "application/json"},);
      if (response.statusCode == 200) {
        isLoading.value=false;
        Categories categoryData = categoriesFromJson(response.body);
        categories.assignAll(categoryData.data);
      }
    } finally {
      isLoading.value = false;
    }
  }
  //
  // Future<void> fetchProductsFromCategory(int index) async {
  //   try {
  //     isLoading.value=true;
  //     var response = await http.get(Uri.parse('${Urls.productByCategory}$index'));
  //     if (response.statusCode == 200) {
  //       isLoading.value=false;
  //       Categories categoryData = categoriesFromJson(response.body);
  //       // categories.assignAll(categoryData.data);
  //       print(response.body);
  //     }
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
