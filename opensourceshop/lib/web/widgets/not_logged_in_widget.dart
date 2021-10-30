import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/screens/login_and_signup_screen/login_and_singup_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotLoggedInWidgetWeb extends StatelessWidget {
  final title;

  NotLoggedInWidgetWeb({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 30.sp,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Get.toNamed(LoginAndSignUpScreen.id),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(MAIN_COLOR)),
                  elevation: MaterialStateProperty.all(5),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize: MaterialStateProperty.all(
                    Size(
                      200.w,
                      50.h,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Text(
                  'إشتراك',
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Get.toNamed(LoginAndSignUpScreen.id),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(MAIN_COLOR)),
                  elevation: MaterialStateProperty.all(5),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize: MaterialStateProperty.all(
                    Size(
                      200.w,
                      50.h,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
