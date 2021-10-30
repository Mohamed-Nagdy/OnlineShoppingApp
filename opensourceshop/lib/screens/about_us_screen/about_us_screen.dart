import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constatnts.dart';

class AboutUsScreen extends StatelessWidget {
  static String id = '/aboutUsScreen';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'من نحن',
            ),
            backgroundColor: Color(MAIN_COLOR),
          ),
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                // MainAppBar(),
                // Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'نحن متجر إلكتروني  ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red[200],
                            fontSize: Get.width * 0.09,
                          ),
                        ),
                        Text(
                          ' متخصصون ببيع ..................',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(MAIN_COLOR),
                            fontSize: Get.width * 0.09,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Divider(),
                // MainBottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
