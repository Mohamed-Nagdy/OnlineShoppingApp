import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/about_us_screen/about_us_screen.dart';
import 'package:opensourceshop/web/chat_screen/chat_screen.dart';
import 'package:opensourceshop/web/login_and_signup_screen/login_and_singup_screen.dart';
import 'package:opensourceshop/web/my_bills_screen/my_bills_screen.dart';
import 'package:opensourceshop/web/widgets/more_tab_widget.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Container(
      child: Column(
        children: [
          // MainTopAppBar(
          //   title: 'المزيد',
          // ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.7,
              ),
              children: [
                MoreTabWidgetWeb(
                  title: 'مشترياتي',
                  icon: FontAwesomeIcons.shoppingBag,
                  onTap: () => Get.toNamed(MyBillsScreenWeb.id),
                ),
                MoreTabWidgetWeb(
                  title: 'سناب شات',
                  icon: FontAwesomeIcons.snapchat,
                  onTap: () async {
                    if (await canLaunch(
                      'https://www.snapchat.com/add/mohamed_nag4898',
                    )) {
                      await launch(
                        'https://www.snapchat.com/add/mohamed_nag4898',
                      );
                    } else {
                      print('can not launche');
                    }
                  },
                ),
                MoreTabWidgetWeb(
                  title: 'إنستجرام',
                  icon: FontAwesomeIcons.instagram,
                  onTap: () async {
                    if (await canLaunch(
                        'https://www.instagram.com/mohamednagdy7/?igshid=1fyhs119h0l1x')) {
                      await launch(
                          'https://www.instagram.com/mohamednagdy7/?igshid=1fyhs119h0l1x');
                    } else {
                      print('can not launche');
                    }
                  },
                ),
                MoreTabWidgetWeb(
                  title: 'فيسبوك',
                  icon: FontAwesomeIcons.facebookF,
                  onTap: () async {
                    if (await canLaunch(
                        'https://www.facebook.com/profile.php?id=100011430643963')) {
                      await launch(
                          'https://www.facebook.com/profile.php?id=100011430643963');
                    } else {
                      print('can not launche');
                    }
                  },
                ),
                if (!kIsWeb)
                  MoreTabWidgetWeb(
                    title: 'شارك التطبيق ',
                    icon: FontAwesomeIcons.shareAlt,
                    onTap: () {
                      Share.share('Share Our App now And Get More Fun');
                    },
                  ),
                MoreTabWidgetWeb(
                  title: 'من نحن',
                  icon: FontAwesomeIcons.addressCard,
                  onTap: () => Get.toNamed(AboutUsScreen.id),
                ),
                MoreTabWidgetWeb(
                  title: 'راسلنا',
                  icon: FontAwesomeIcons.facebookMessenger,
                  onTap: provider.isLoggedIn
                      ? () => Get.toNamed(ChatScreenWeb.id)
                      : () => Get.toNamed(LoginAndSignUpScreenWeb.id),
                ),
                MoreTabWidgetWeb(
                  title: 'إتصل بنا',
                  icon: FontAwesomeIcons.phoneAlt,
                  onTap: () async {
                    if (await canLaunch('tel:+201558400064')) {
                      await launch('tel:+201558400064');
                    } else {
                      print('can not launche');
                    }
                  },
                ),
                MoreTabWidgetWeb(
                  title: 'موقعنا',
                  icon: FontAwesomeIcons.mapMarkerAlt,
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
                MoreTabWidgetWeb(
                  title: provider.isLoggedIn ? 'تسجيل الخروج' : 'تسجيل الدخول',
                  icon: provider.isLoggedIn
                      ? FontAwesomeIcons.signOutAlt
                      : FontAwesomeIcons.signInAlt,
                  onTap: provider.isLoggedIn
                      ? () => provider.logout()
                      : () => Get.toNamed(LoginAndSignUpScreenWeb.id),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
