import 'package:flutter/material.dart';
import 'package:opensourceshop/constatnts.dart';

class MoreTabWidgetWeb extends StatelessWidget {
  final title, onTap, icon;

  MoreTabWidgetWeb({
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
        child: Column(
          children: [
            Icon(
              icon,
              color: Color(MAIN_COLOR),
              size: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 28,
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
