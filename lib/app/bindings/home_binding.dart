import 'package:get/get.dart';
import 'package:mplayer/app/controllers/mplayerController.dart';
import '../controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MplayerController>(() => MplayerController());
  }
}
