import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opensourceshop/web/main_screen_web/main_screen_web.dart';

class OrderSubmittedScreenWeb extends StatelessWidget {
  static String id = '/orderSubmittedScreenWeb';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'تم الطلب',
            ),
            backgroundColor: Color(MAIN_COLOR),
          ),
          backgroundColor: Colors.white,
          body: Container(
            width: Get.width,
            alignment: Alignment.center,
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
                          'تم تأكيد طلبك بنجاح',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red[200],
                            fontSize: 28.sp,
                          ),
                        ),
                        Text(
                          'يتم التوصيل خلال يومين إلى اربع أيام',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(MAIN_COLOR),
                            fontSize: 28.sp,
                          ),
                        ),
                        Text(
                          'نرجو أن تكون تجربتك معنا لا تنسى فنحن لن ننساك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red[200],
                            fontSize: 28.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Divider(),
                // HeartButton(
                //   onTap: () => Get.offAllNamed(
                //     MainAppScreen.id,
                //   ),
                //   icon: FontAwesomeIcons.home,
                // ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.home,
                      size: 20,
                      color: Color(MAIN_COLOR),
                    ),
                    onPressed: () => Get.offAllNamed(MainScreenWeb.id),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
