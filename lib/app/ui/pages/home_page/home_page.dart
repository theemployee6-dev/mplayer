import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/app/m_player/mplayer.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.redAccent,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Obx(() {
                  return _.mplayerController.fullScreen
                      ? Container()
                      : Mplayer(controller: _.mplayerController);
                }),
                SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _.videos.length,
                    itemBuilder: (ctx, index) {
                      final video = _.videos[index];
                      return Card(
                        elevation: 8.0,
                        child: ListTile(
                          title: Text(
                            video.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(video.description, maxLines: 2),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
