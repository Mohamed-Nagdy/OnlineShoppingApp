import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';

class CategoryWidget extends StatelessWidget {
  final onTap, image, title;
  CategoryWidget({
    this.onTap,
    this.image,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        height: Get.height * 0.12,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: SHADOW,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                image,
                fit: BoxFit.fill,
                width: Get.width,
              ),
            ),
            Container(
              width: Get.width,
              height: Get.height,
              child: Text(''),
              color: Colors.black12,
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
