import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/screens/login_and_signup_screen/login_and_singup_screen.dart';

class NotLoggedInWidget extends StatelessWidget {
  final title;

  NotLoggedInWidget({this.title});

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
                fontSize: Get.width * 0.05,
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
                    fontSize: Get.width * 0.04,
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
                      Get.width * 0.7,
                      Get.height * 0.05,
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
                    fontSize: Get.width * 0.04,
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
                      Get.width * 0.7,
                      Get.height * 0.05,
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
