import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inam_ecomerce_app/AppTheme/AppColors.dart';

import '../Controllers/HomeController.dart';
import '../Controllers/UserController.dart';
import '../Validators/InternetValidator.dart';

class PRofileScreen extends StatefulWidget {
  const PRofileScreen({super.key});

  @override
  State<PRofileScreen> createState() => _PRofileScreenState();
}

class _PRofileScreenState extends State<PRofileScreen> {

  String? name, deliveryAddress;
  var localStorage = GetStorage();
  late String showname, showaddress;
  bool isLoginData = false;

  @override
  void initState() {
    getNameAddress();
    super.initState();
  }

  getNameAddress() async{
    name = await localStorage.read("name");
    deliveryAddress = await localStorage.read("address");
    if(name !=null && deliveryAddress!=null){
      setState(() {
        showname = name!;
        showaddress = deliveryAddress!;
        isLoginData=true;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    final HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          "User Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            children: [
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  width: Get.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: Colors.white),
                  child: Obx(()=>Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.asset("Assets/Images/LOGO.png"),
                      ),
                      userController.isLogin.value?
                      Container(
                        child: isLoginData? Column(
                          children: [
                            Text(showname,
                              style: const TextStyle(
                                  color: AppColors.backgroundColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24
                              ),
                            ),
                            Text(showaddress,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14
                              ),
                            ),
                          ],
                        ):CircularProgressIndicator(),
                      )
                          :SizedBox()
                    ],
                  )),
                ),
              ),
            ],
          ),
          Obx(
            () => userController.isLogin.value
                ? userController.isLoading.value
                    ? const Center(child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ))
                    : Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 50),
                              child: InkWell(
                                onTap: () async {
                                  bool isInternetAvailable =
                                      await InternetValidator
                                          .isInternetAvailable();
                                  if (isInternetAvailable == true) {
                                    userController.fetchOrders();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "No Internet Available. Try Again",
                                        toastLength: Toast.LENGTH_LONG);
                                  }
                                },
                                child: Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white),
                                  child: const ListTile(
                                    leading: Icon(
                                      Icons.library_add_check_rounded,
                                      color: AppColors.backgroundColor,
                                    ),
                                    trailing: Icon(
                                      Icons.navigate_next,
                                      color: AppColors.backgroundColor,
                                    ),
                                    title: Text("My Orders"),
                                  ),
                                ),
                              ),
                            )))
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          color: Colors.black,
                        )),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Log in or Sign Up",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Log in to place an order",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    homeController.isHomeScreen.value = false;
                                    homeController.isCheckOutScreen.value =
                                        false;
                                    homeController.isProfileScreen.value =
                                        false;
                                    homeController.isProductScreen.value =
                                        false;
                                    homeController.isNumberVerificationScreen
                                        .value = true;
                                    homeController.isOrderListScreen.value =
                                        false;
                                    homeController
                                        .isOTPVerificationScreen.value = false;
                                    homeController.isRegisterScreen.value =
                                        false;
                                  },
                                  child: Text("Let's Go"),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
