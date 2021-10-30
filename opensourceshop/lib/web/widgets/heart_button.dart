import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constatnts.dart';

class HeartButton extends StatelessWidget {
  final icon, title, onTap, showText, backIconSize, frontIconSize, top, left;

  HeartButton({
    this.icon,
    this.title,
    this.onTap,
    this.showText = false,
    this.backIconSize = 85.0,
    this.frontIconSize = 25.0,
    this.top = 35.0,
    this.left = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Icon(
                  FontAwesomeIcons.solidHeart,
                  color: Color(MAIN_COLOR),
                  size: backIconSize,
                ),
              ),
              Positioned(
                left: left,
                top: top,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: frontIconSize,
                ),
              ),
            ],
          ),
        ),
        if (showText)
          Text(
            title,
          ),
      ],
    );
  }
}
