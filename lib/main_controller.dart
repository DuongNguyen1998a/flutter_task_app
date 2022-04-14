import 'package:get/get.dart';

class MainController extends GetxController {
  var widthOfScreen = 0.0.obs;
  var heightOfScreen = 0.0.obs;

  @override
  void onInit() {
    widthOfScreen.value = Get.width;
    heightOfScreen.value = Get.height;
    super.onInit();
  }
}