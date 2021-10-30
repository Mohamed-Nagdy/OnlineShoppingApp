import 'package:flutter/material.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/web/main_screen_web/main_screen_web_tabs/cart_tab.dart';
import 'package:opensourceshop/web/main_screen_web/main_screen_web_tabs/fav_tab.dart';
import 'package:opensourceshop/web/main_screen_web/main_screen_web_tabs/home_tab.dart';
import 'package:opensourceshop/web/main_screen_web/main_screen_web_tabs/more_tab.dart';
import 'package:opensourceshop/web/main_screen_web/main_screen_web_tabs/profile_tab.dart';
import 'package:opensourceshop/web/widgets/main_top_app_bar.dart';

class MainScreenWeb extends StatefulWidget {
  static String id = '/mainScreenWeb';

  @override
  _MainScreenWebState createState() => _MainScreenWebState();
}

class _MainScreenWebState extends State<MainScreenWeb> {
  List containers = [];
  Widget tab = HomeTab();
  String title = 'الرئيسية';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Column(
            children: [
              MainTopAppBar(
                title: title,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        onPressed: () => setState(() {
                          tab = HomeTab();
                          title = 'الرئيسية';
                        }),
                        child: Text(
                          'الرئيسية',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        onPressed: () => setState(() {
                          tab = FavTab();
                          title = 'المفضلة';
                        }),
                        child: Text(
                          'المفضلة',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        onPressed: () => setState(() {
                          tab = CartTab();
                          title = 'السلة';
                        }),
                        child: Text(
                          'السلة',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        onPressed: () => setState(() {
                          tab = ProfileTab();
                          title = 'البروفايل';
                        }),
                        child: Text(
                          'البروفايل',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        onPressed: () => setState(() {
                          tab = MoreTab();
                          title = 'المزيد';
                        }),
                        child: Text(
                          'المزيد',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                height: 50,
                color: Color(MAIN_COLOR),
              ),
              Expanded(
                child: tab,
              ),
            ],
          ),
          backgroundColor: Color(0XFFF8F8F8),
          // bottomNavigationBar: ConvexAppBar(
          //   height: Get.height * 0.06,
          //   style: TabStyle.react,
          //   activeColor: Color(MAIN_COLOR),
          //   color: Colors.grey,
          //   backgroundColor: Colors.white,
          //   items: [
          //     TabItem(
          //       icon: Icons.home,
          //       // title: 'الرئيسية',
          //     ),
          //     TabItem(
          //       icon: Icons.favorite_border_rounded,
          //       // title: 'المفضلة',
          //     ),
          //     TabItem(
          //       icon: Icons.shopping_cart_outlined,
          //       // title: 'السلة',
          //     ),
          //     TabItem(
          //       icon: Icons.person_outlined,
          //       // title: 'البروفايل',
          //     ),
          //     TabItem(
          //       icon: Icons.more_vert,
          //       // title: 'المزيد',
          //     ),
          //   ],
          //   initialActiveIndex: 0,
          //   onTap: (index) {
          //     setState(() {
          //       switch (index) {
          //         case 0:
          //           tab = HomeTab();
          //           break;

          //         case 1:
          //           tab = FavTab();
          //           break;

          //         case 2:
          //           tab = CartTab();
          //           break;

          //         case 3:
          //           tab = ProfileTab();
          //           break;

          //         case 4:
          //           tab = MoreTab();
          //           break;
          //       }
          //     });
          //   },
          // ),
        ),
      ),
    );
  }
}
