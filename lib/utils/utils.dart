import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternetAvailable() async {
  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    rethrow;
  }
}
