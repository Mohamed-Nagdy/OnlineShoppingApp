import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/screens/widgets/heart_button.dart';

class MainBottomBar extends StatelessWidget {
  final showSave, onSaveButtonTap;

  MainBottomBar({this.showSave = false, this.onSaveButtonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.167,
      child: Row(
        children: [
          if (showSave)
            HeartButton(
              icon: FontAwesomeIcons.save,
              title: '',
              onTap: onSaveButtonTap,
            ),
          Expanded(
            child: Image.asset(
              'images/logo.png',
            ),
          ),
          HeartButton(
            icon: FontAwesomeIcons.arrowLeft,
            title: '',
            onTap: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
