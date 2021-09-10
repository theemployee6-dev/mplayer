import 'package:flutter/material.dart';
import 'package:mplayer/app/controllers/mplayerController.dart';
import 'package:mplayer/app/m_player/mplayer.dart';

class MplayerFullScreen extends StatelessWidget {
  final MplayerController controller;
  const MplayerFullScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Mplayer(controller: this.controller),
      ),
    );
  }
}
