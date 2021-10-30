import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constatnts.dart';

class CustomButton extends StatelessWidget {
  final title, onTap, widthFactor;

  CustomButton({this.title, this.onTap, this.widthFactor = 0.8});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          vertical: 30,
        ),
        padding: const EdgeInsets.all(10),
        width: Get.width * widthFactor,
        decoration: BoxDecoration(
          color: Color(MAIN_COLOR),
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: Get.width * 0.04,
          ),
        ),
      ),
    );
  }
}
