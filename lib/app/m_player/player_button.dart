import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerButton extends StatelessWidget {
  const PlayerButton(
      {Key? key,
      required this.size,
      required this.iconPath,
      required this.onPressed,
      this.backgroundColor = Colors.white54,
      this.iconcolor = Colors.black})
      : super(key: key);
  final double? size;
  final String? iconPath;
  final Color backgroundColor;
  final Color iconcolor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.all(this.size! * 0.25),
          height: this.size,
          width: this.size,
          child: Image.asset(this.iconPath!, color: this.iconcolor),
          decoration: BoxDecoration(
            color: this.backgroundColor,
            shape: BoxShape.circle,
          ),
        ),
        onPressed: this.onPressed);
  }
}
