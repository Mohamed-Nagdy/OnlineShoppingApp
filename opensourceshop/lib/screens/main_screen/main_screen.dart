import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';
import 'main_screen_tabs/cart_tab.dart';
import 'main_screen_tabs/fav_tab.dart';
import 'main_screen_tabs/home_tab.dart';
import 'main_screen_tabs/more_tab.dart';
import 'main_screen_tabs/profile_tab.dart';

class MainScreen extends StatefulWidget {
  static String id = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List containers = [];
  Widget tab = HomeTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: tab,
          backgroundColor: Color(0XFFF8F8F8),
          bottomNavigationBar: ConvexAppBar(
            height: Get.height * 0.06,
            style: TabStyle.react,
            activeColor: Color(MAIN_COLOR),
            color: Colors.grey,
            backgroundColor: Colors.white,
            items: [
              TabItem(
                icon: Icons.home,
                // title: 'الرئيسية',
              ),
              TabItem(
                icon: Icons.favorite_border_rounded,
                // title: 'المفضلة',
              ),
              TabItem(
                icon: Icons.shopping_cart_outlined,
                // title: 'السلة',
              ),
              TabItem(
                icon: Icons.person_outlined,
                // title: 'البروفايل',
              ),
              TabItem(
                icon: Icons.more_vert,
                // title: 'المزيد',
              ),
            ],
            initialActiveIndex: 0,
            onTap: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    tab = HomeTab();
                    break;

                  case 1:
                    tab = FavTab();
                    break;

                  case 2:
                    tab = CartTab();
                    break;

                  case 3:
                    tab = ProfileTab();
                    break;

                  case 4:
                    tab = MoreTab();
                    break;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
