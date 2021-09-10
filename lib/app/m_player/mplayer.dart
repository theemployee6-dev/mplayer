import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/app/controllers/mplayerController.dart';
import 'package:mplayer/app/m_player/mplayer_controlls.dart';
import 'package:video_player/video_player.dart';

class Mplayer extends StatelessWidget {
  final MplayerController controller;
  Mplayer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MplayerController>(
      init: controller,
      builder: (_) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _.videoController != null &&
                          _.videoController!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoPlayer(_.videoController!),
                        )
                      : Container(),
                  Obx(() {
                    if (_.loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (_.error) {
                      return Text('Error');
                    } else if (_.none) {
                      return Container();
                    }
                    return MplayerControlls();
                  }),
                ],
              )),
        );
      },
    );
  }
}
