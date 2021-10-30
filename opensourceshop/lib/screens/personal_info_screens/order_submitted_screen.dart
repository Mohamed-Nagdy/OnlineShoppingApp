import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/screens/main_screen/main_screen.dart';

class OrderSubmittedScreen extends StatelessWidget {
  static String id = '/orderSubmittedScreen';

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
                            fontSize: Get.width * 0.09,
                          ),
                        ),
                        Text(
                          'يتم التوصيل خلال يومين إلى اربع أيام',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(MAIN_COLOR),
                            fontSize: Get.width * 0.09,
                          ),
                        ),
                        Text(
                          'نرجو أن تكون تجربتك معنا لا تنسى فنحن لن ننساك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red[200],
                            fontSize: Get.width * 0.09,
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
                  padding: const EdgeInsets.all(15.0),
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.home,
                      size: 40,
                      color: Color(MAIN_COLOR),
                    ),
                    onPressed: () => Get.offAllNamed(MainScreen.id),
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
