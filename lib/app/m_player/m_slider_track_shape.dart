import 'package:flutter/material.dart';

class MSliderTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    return Rect.fromLTWH(
      offset.dx,
      offset.dy + parentBox.size.height / 2 - 2,
      parentBox.size.width,
      4,
    );
  }
}
