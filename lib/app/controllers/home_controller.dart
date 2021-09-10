import 'package:get/get.dart';
import 'package:mplayer/app/controllers/mplayerController.dart';
import 'package:mplayer/app/data/models/video_model.dart';
import 'package:mplayer/app/ui/utils/videos.dart' as v;

class HomeController extends GetxController {
  List<VideoModel> _videos = [];
  List<VideoModel> get videos => _videos;
  final MplayerController _mplayerController = Get.find();
  MplayerController get mplayerController => _mplayerController;

  @override
  void onReady() {
    super.onReady();
    fetchVideos();
    _mplayerController.loadVideo(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4");
  }

  @override
  void onClose() {
    _mplayerController.dispose();
    super.onClose();
  }

  List<VideoModel> fetchVideos() {
    var dados =
        this._videos = v.videos.map((e) => VideoModel.fromJson(e)).toList();
    update();
    return dados;
  }
}
