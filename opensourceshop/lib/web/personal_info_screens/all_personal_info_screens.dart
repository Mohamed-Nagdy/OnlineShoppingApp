import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/main_app_screen/main_app_screen.dart';
import 'package:opensourceshop/screens/main_screen/main_screen_tabs/profile_tab.dart';
import 'package:opensourceshop/screens/my_bills_screen/my_bills_screen.dart';
import 'package:opensourceshop/web/main_screen_web/main_screen_web_tabs/fav_tab.dart';
import 'package:opensourceshop/web/widgets/heart_button.dart';
import 'package:opensourceshop/web/widgets/main_app_bar.dart';
import 'package:opensourceshop/web/widgets/main_bottom_bar.dart';
import 'package:provider/provider.dart';

class AllPersonalInfoScreenWeb extends StatelessWidget {
  static String id = '/allPersonalInfoScreenWeb';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              MainAppBar(),
              Divider(),
              Expanded(
                child: Column(
                  children: [
                    // InkWell(
                    //   onTap: () => Get.toNamed(LastSeenScreen.id),
                    //   child: Row(
                    //     children: [
                    //       HeartButton(
                    //         icon: FontAwesomeIcons.clock,
                    //       ),
                    //       Text(
                    //         'شاهدت مؤخرا',
                    //         style: TextStyle(
                    //           fontSize: Get.width * 0.07,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () => Get.toNamed(FavTab.id),
                      child: Row(
                        children: [
                          HeartButton(
                            icon: FontAwesomeIcons.plus,
                          ),
                          Text(
                            'مفضلاتي',
                            style: TextStyle(
                              fontSize: Get.width * 0.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(MyBillsScreen.id),
                      child: Row(
                        children: [
                          HeartButton(
                            icon: FontAwesomeIcons.shoppingBag,
                          ),
                          Text(
                            'مشترياتي',
                            style: TextStyle(
                              fontSize: Get.width * 0.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(ProfileTab.id, arguments: {}),
                      child: Row(
                        children: [
                          HeartButton(
                            icon: FontAwesomeIcons.addressCard,
                          ),
                          Text(
                            'معلوماتي',
                            style: TextStyle(
                              fontSize: Get.width * 0.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        var userProvider = Provider.of<UserProvider>(
                          context,
                          listen: false,
                        );
                        final storage = GetStorage();
                        storage.write('email', null);
                        storage.write('password', null);
                        userProvider.logout();
                        Get.offAllNamed(MainAppScreen.id);
                      },
                      child: Row(
                        children: [
                          HeartButton(
                            icon: FontAwesomeIcons.signOutAlt,
                          ),
                          Text(
                            'تسجيل الخروج',
                            style: TextStyle(
                              fontSize: Get.width * 0.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              MainBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
