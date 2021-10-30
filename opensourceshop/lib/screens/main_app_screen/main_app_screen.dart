import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/about_us_screen/about_us_screen.dart';
import 'package:opensourceshop/screens/chat_screen/chat_screen.dart';
import 'package:opensourceshop/screens/login_and_signup_screen/login_and_singup_screen.dart';
import 'package:opensourceshop/screens/main_categories_screen/main_categories_screen.dart';
import 'package:opensourceshop/screens/widgets/heart_button.dart';
import 'package:opensourceshop/screens/widgets/main_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class MainAppScreen extends StatefulWidget {
  static String id = '/mainAppScreen';

  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var userProvider = Provider.of<UserProvider>(context);
    if (isInit) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        final storage = GetStorage();
        if (storage.read('email') != null) {
          // Get.dialog(
          //   Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // );
          final email = storage.read('email');
          final password = storage.read('password');

          await userProvider.loginAndSignUpAndEdit(
            {
              "email": email,
              "password": password,
            },
            'https://opensourceshop-app-control-panel.herokuapp.com/api/v1/users/login',
          );
          // Get.back();
          isInit = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MainAppBar(),
                  Image.asset(
                    'images/logo.png',
                    height: Get.height * 0.2,
                  ),
                  Container(
                    height: Get.height,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      children: [
                        HeartButton(
                          icon: FontAwesomeIcons.phoneAlt,
                          title: 'إتصلي بنا',
                          showText: true,
                          onTap: () async {
                            if (await canLaunch('tel:+970 568 204 208')) {
                              await launch('tel:+970 568 204 208');
                            } else {
                              print('can not launche');
                            }
                          },
                        ),
                        HeartButton(
                          icon: FontAwesomeIcons.envelope,
                          title: 'راسلينا',
                          showText: true,
                          // onTap: () async {
                          //   final String encodedURl = Uri.encodeFull(
                          //     'whatsapp://send?phone=+970 568 204 208',
                          //   );
                          //   if (await canLaunch(encodedURl)) {
                          //     await launch(encodedURl);
                          //   } else {
                          //     print('can not launche');
                          //   }
                          // },
                          onTap: provider.isLoggedIn
                              ? () => Get.toNamed(ChatScreen.id)
                              : () => Get.toNamed(LoginAndSignUpScreen.id),
                        ),
                        HeartButton(
                          icon: FontAwesomeIcons.shoppingBag,
                          title: 'تسوقي',
                          onTap: () => Get.toNamed(MainCategoriesScreen.id),
                          showText: true,
                        ),
                        HeartButton(
                          icon: FontAwesomeIcons.snapchatGhost,
                          title: 'سناب شات',
                          onTap: () async {
                            if (await canLaunch(
                                'https://www.snapchat.com/add/opensourceshopcozy')) {
                              await launch(
                                  'https://www.snapchat.com/add/opensourceshopcozy');
                            } else {
                              print('can not launche');
                            }
                          },
                          showText: true,
                        ),
                        HeartButton(
                          icon: FontAwesomeIcons.instagram,
                          title: 'انستجرام',
                          onTap: () async {
                            if (await canLaunch(
                                'https://instagram.com/opensourceshopcozy?igshid=1fyhs119h0l1x')) {
                              await launch(
                                  'https://instagram.com/opensourceshopcozy?igshid=1fyhs119h0l1x');
                            } else {
                              print('can not launche');
                            }
                          },
                          showText: true,
                        ),
                        HeartButton(
                          icon: FontAwesomeIcons.facebookF,
                          title: 'فيسبوك',
                          onTap: () async {
                            if (await canLaunch(
                                'https://www.facebook.com/opensourceshopcozy/')) {
                              await launch(
                                  'https://www.facebook.com/opensourceshopcozy/');
                            } else {
                              print('can not launche');
                            }
                          },
                          showText: true,
                        ),
                        HeartButton(
                          icon: FontAwesomeIcons.shareAlt,
                          title: 'شاركي',
                          showText: true,
                          onTap: () {
                            Share.share('Share Our App now And Get More Fun');
                          },
                        ),
                        HeartButton(
                          icon: FontAwesomeIcons.addressCard,
                          title: 'من نحن',
                          onTap: () => Get.toNamed(AboutUsScreen.id),
                          showText: true,
                        ),
                        HeartButton(
                          icon: FontAwesomeIcons.mapMarkerAlt,
                          title: 'موقعنا',
                          showText: true,
                          onTap: () async {
                            final String googleMapslocationUrl =
                                "https://www.google.com/maps/search/?api=1&query=31.9038,35.2034";
                            final String encodedURl =
                                Uri.encodeFull(googleMapslocationUrl);
                            if (await canLaunch(encodedURl)) {
                              await launch(encodedURl);
                            } else {
                              print('can not launche');
                            }
                          },
                        ),
                      ],
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
