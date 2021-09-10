import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/app/controllers/mplayerController.dart';
import 'package:mplayer/app/m_player/m_slider.dart';
import 'package:mplayer/app/m_player/player_button.dart';
import 'package:mplayer/app/ui/utils/extras.dart';

class MplayerControlls extends StatelessWidget {
  const MplayerControlls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MplayerController>(
      builder: (_) => Positioned.fill(
        child: Obx(() {
          return GestureDetector(
            onTap: _.onShowControls,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: _.showcontrols ? Colors.black54 : Colors.transparent,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AbsorbPointer(
                    absorbing: !_.showcontrols,
                    child: AnimatedOpacity(
                      opacity: _.showcontrols ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PlayerButton(
                            onPressed: _.rewind,
                            size: 50,
                            iconPath: "assets/icons/rewind.png",
                          ),
                          SizedBox(width: 20),
                          Obx(() {
                            String iconPath = "assets/icons/repeat.png";
                            if (_.playing) {
                              iconPath = "assets/icons/pause.png";
                            } else if (_.paused) {
                              iconPath = "assets/icons/play.png";
                            }
                            return PlayerButton(
                              onPressed: () {
                                if (_.playing) {
                                  _.pause();
                                } else {
                                  _.play();
                                }
                              },
                              size: 60,
                              iconPath: iconPath,
                            );
                          }),
                          SizedBox(width: 20),
                          PlayerButton(
                            onPressed: _.fastForward,
                            size: 50,
                            iconPath: "assets/icons/fast-forward.png",
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    bottom: _.showcontrols ? 0 : -70,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.black26,
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              parseDuration(_.position),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                          Mslider(),
                          SizedBox(width: 10),
                          Obx(() {
                            return PlayerButton(
                              size: 35,
                              backgroundColor: Colors.transparent,
                              iconcolor: Colors.white,
                              iconPath: _.mute
                                  ? "assets/icons/mute.png"
                                  : "assets/icons/sound.png",
                              onPressed: _.onMute,
                            );
                          }),
                          Obx(
                            () => Text(
                              parseDuration(_.duration),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          Obx(() {
                            return PlayerButton(
                              size: 35,
                              backgroundColor: Colors.transparent,
                              iconcolor: Colors.white,
                              iconPath: _.fullScreen
                                  ? "assets/icons/minimize.png"
                                  : "assets/icons/fullscreen.png",
                              onPressed: _.onFullScreen,
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
