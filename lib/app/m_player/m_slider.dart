import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/app/controllers/mplayerController.dart';
import 'package:mplayer/app/m_player/m_slider_track_shape.dart';
import 'package:mplayer/app/ui/utils/extras.dart';

class Mslider extends StatelessWidget {
  const Mslider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MplayerController>(
      builder: (_) => Expanded(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              child: LayoutBuilder(builder: (ctx, constraints) {
                return Obx(() {
                  double percent = 0;
                  if (_.bufferedLoaded.inSeconds > 0) {
                    percent = _.bufferedLoaded.inSeconds / _.duration.inSeconds;
                  }
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    color: Colors.white30,
                    height: 5,
                    width: constraints.maxWidth * percent,
                  );
                });
              }),
            ),
            Obx(() {
              final int value = _.sliderPosition.inSeconds;
              final double max = _.duration.inSeconds.toDouble();
              if (value > max || max <= 0) {
                return Container();
              }
              return SliderTheme(
                data: SliderThemeData(
                  thumbColor: Colors.red[900],
                  activeTrackColor: Colors.red[900],
                  trackShape: MSliderTrackShape(),
                ),
                child: Slider(
                  min: 0,
                  max: max,
                  divisions: _.duration.inSeconds,
                  label: parseDuration(_.sliderPosition),
                  value: value.toDouble(),
                  onChanged: _.onChangeSlider,
                  onChangeStart: (v) {
                    _.onChangeSliderStart();
                  },
                  onChangeEnd: (v) {
                    _.onChangeSliderEnd();
                    _.seekTo(Duration(seconds: v.floor()));
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
