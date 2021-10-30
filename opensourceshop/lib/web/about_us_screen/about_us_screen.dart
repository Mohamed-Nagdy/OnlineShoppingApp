import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constatnts.dart';

class AboutUsScreenWeb extends StatelessWidget {
  static String id = '/aboutUsScreenWeb';

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'نحن متجر إلكتروني  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red[200],
                      fontSize: 28.sp,
                    ),
                  ),
                  Text(
                    ' متخصصون ببيع ..................',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(MAIN_COLOR),
                      fontSize: 28.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
