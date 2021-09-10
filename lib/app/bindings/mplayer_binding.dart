import 'package:get/get.dart';
import 'package:mplayer/app/controllers/mplayerController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MplayerController>(() => MplayerController());
  }
}
