import 'package:connectivity_plus/connectivity_plus.dart';

class InternetValidator{
  static Future<bool> isInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      return false;
    } else {
      // Internet connection is available
      return true;
    }
  }
}