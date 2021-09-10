import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mplayer/app/m_player/m_player_fullscreen.dart';
import 'package:video_player/video_player.dart';

enum SourceStatus { none, loading, loaded, error }
enum PlayingStatus { stopped, playing, paused }

class MplayerController extends GetxController {
  VideoPlayerController? _videoController;
  VideoPlayerController? get videoController => _videoController;

  Rx<Duration> _bufferedLoaded = Duration.zero.obs;
  Duration get bufferedLoaded => _bufferedLoaded.value;

  Rx<Duration> _position = Duration.zero.obs;
  Duration get position => _position.value;

  Rx<Duration> _sliderPosition = Duration.zero.obs;
  Duration get sliderPosition => _sliderPosition.value;

  RxBool _mute = false.obs;
  bool get mute => _mute.value;

  RxBool _fullScreen = false.obs;
  bool get fullScreen => _fullScreen.value;

  RxBool _showControls = false.obs;
  bool get showcontrols => _showControls.value;

  bool _isSliderMoving = false;

  Rx<Duration> _duration = Duration.zero.obs;
  Duration get duration => _duration.value;

  Rx<SourceStatus> _sourceStatus = SourceStatus.none.obs;
  SourceStatus get sourceStatus => _sourceStatus.value;

  Rx<PlayingStatus> _playingStatus = PlayingStatus.stopped.obs;
  PlayingStatus get playingStatus => _playingStatus.value;

  late Timer _timer;

  bool get none {
    return _sourceStatus.value == SourceStatus.none;
  }

  bool get loading {
    return _sourceStatus.value == SourceStatus.loading;
  }

  bool get loaded {
    return _sourceStatus.value == SourceStatus.loaded;
  }

  bool get error {
    return _sourceStatus.value == SourceStatus.error;
  }

  //PlayingStatus

  bool get playing {
    return _playingStatus.value == PlayingStatus.playing;
  }

  bool get stopped {
    return _playingStatus.value == PlayingStatus.stopped;
  }

  bool get paused {
    return _playingStatus.value == PlayingStatus.paused;
  }
  //PlayingStatus End

  Future<void> loadVideo(String url) async {
    try {
      _playingStatus.value = PlayingStatus.paused;
      _sourceStatus.value = SourceStatus.loading;
      _videoController = VideoPlayerController.network(url);
      _showControls.value = true;
      await _videoController!.initialize();

      final duration = _videoController!.value.duration;
      if (_duration.value.inSeconds != duration.inSeconds) {
        _duration.value = duration;
      }

      _videoController!.addListener(() {
        final position = _videoController!.value.position;
        _position.value = position;

        if (!_isSliderMoving) {
          _sliderPosition.value = position;
        }

        if (_position.value.inSeconds >= duration.inSeconds && !stopped) {
          _playingStatus.value = PlayingStatus.stopped;
        }
        _bufferedLoaded.value = _videoController!.value.buffered.last.end;
      });
      _sourceStatus.value = SourceStatus.loaded;
      update();
    } catch (e) {
      _sourceStatus.value = SourceStatus.error;
    }
  }

  Future<void> play() async {
    if (stopped || paused) {
      if (stopped) {
        await _videoController!.seekTo(Duration.zero);
      }
      await _videoController!.play();
      _playingStatus.value = PlayingStatus.playing;
      _hideTaskControls(6);
    }
  }

  Future<void> pause() async {
    if (playing) {
      await _videoController!.pause();
      _playingStatus.value = PlayingStatus.paused;
    }
  }

  Future<void> seekTo(Duration position) async {
    await _videoController!.seekTo(position);
  }

  Future<void> fastForward() async {
    final to = position.inSeconds + 10;
    if (duration.inSeconds > 10) {
      await seekTo(Duration(seconds: to));
    }
  }

  Future<void> rewind() async {
    final to = position.inSeconds - 10;

    await seekTo(Duration(seconds: to < 0 ? 0 : to));
  }

  void onChangeSliderStart() {
    _isSliderMoving = true;
  }

  void onChangeSliderEnd() {
    _isSliderMoving = false;
    if (stopped) {
      _playingStatus.value = PlayingStatus.paused;
    }
  }

  onChangeSlider(double v) {
    _sliderPosition.value = Duration(seconds: v.floor());
  }

  Future<void> onMute() async {
    _mute.value = !_mute.value;
    await _videoController!.setVolume(mute ? 0 : 1);
  }

  onShowControls() {
    _showControls.value = !_showControls.value;
    if (showcontrols) {
      _hideTaskControls(5);
    }
  }

  void _hideTaskControls(int duration) {
    _timer = Timer(Duration(seconds: duration), () {
      onShowControls();
      _timer = 0 as Timer;
    });
  }

  Future<void> onFullScreen() async {
    _fullScreen.value = !_fullScreen.value;
    if (fullScreen) {
      await _fullScreenOn();
    } else {
      Get.back();
    }
  }

  Future<void> _fullScreenOn() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp
    ]);
    await Get.to(() => MplayerFullScreen(controller: this),
        transition: Transition.fade, duration: Duration.zero);

    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _fullScreen.value = false;
  }

  @override
  Future<void> dispose() async {
    _timer.cancel();
    await _videoController!.dispose();
    return super.dispose();
  }
}
