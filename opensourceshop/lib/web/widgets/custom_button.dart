import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          vertical: 10,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(MAIN_COLOR),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
          ),
        ),
      ),
    );
  }
}
