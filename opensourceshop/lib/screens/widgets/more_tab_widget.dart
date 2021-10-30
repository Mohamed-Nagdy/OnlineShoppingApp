import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';

class MoreTabWidget extends StatelessWidget {
  final title, onTap, icon;

  MoreTabWidget({
    this.title,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(
              icon,
              color: Color(MAIN_COLOR),
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: Get.width * 0.045,
              ),
            ),
            // Divider(
            //   thickness: 2,
            // ),
          ],
        ),
      ),
    );
  }
}
