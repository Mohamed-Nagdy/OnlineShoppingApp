import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constatnts.dart';

class MainTopAppBar extends StatelessWidget {
  final title;

  MainTopAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      alignment: Alignment.center,
      color: Color(MAIN_COLOR),
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            padding: const EdgeInsets.all(0),
            width: 50,
            height: 50,
            child: Image.asset(
              'images/logo.png',
              // width: 40,
              // height: 40,
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
