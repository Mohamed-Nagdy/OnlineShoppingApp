import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/login_and_signup_screen/login_and_singup_screen.dart';
import 'package:opensourceshop/screens/main_screen/main_screen.dart';
import 'package:opensourceshop/screens/main_screen/main_screen_tabs/cart_tab.dart';
import 'package:opensourceshop/screens/personal_info_screens/all_personal_info_screens.dart';
import 'package:opensourceshop/screens/search_screen/search_screen.dart';
import 'package:opensourceshop/screens/widgets/heart_button.dart';
import 'package:provider/provider.dart';

import '../../constatnts.dart';

class MainAppBar extends StatelessWidget {
  final showSearch;
  final TextEditingController searchController = TextEditingController();

  MainAppBar({this.showSearch = false});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HeartButton(
              icon: FontAwesomeIcons.shoppingCart,
              title: '',
              onTap: () => userProvider.isLoggedIn
                  ? Get.toNamed(CartTab.id)
                  : Get.toNamed(LoginAndSignUpScreen.id),
            ),
            HeartButton(
              icon: FontAwesomeIcons.user,
              title: '',
              onTap: () => userProvider.isLoggedIn
                  ? Get.toNamed(AllPersonalInfoScreen.id)
                  : Get.toNamed(LoginAndSignUpScreen.id),
            ),
            HeartButton(
              icon: FontAwesomeIcons.home,
              title: '',
              onTap: () => Get.toNamed(MainScreen.id),
            ),
          ],
        ),
        if (showSearch == true)
          Container(
            padding: const EdgeInsets.all(10),
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     vertical: 0,
                  //     horizontal: 10,
                  //   ),
                  //   child: Text(
                  //     'search',
                  //   ),
                  // ),
                  TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(MAIN_COLOR),
                          )),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(MAIN_COLOR),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(MAIN_COLOR),
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(MAIN_COLOR),
                          )),
                      contentPadding: const EdgeInsets.all(5),
                      hintText: 'Search',
                      prefixIcon: InkWell(
                        onTap: () {
                          Get.toNamed(
                            SearchScreen.id,
                            arguments: {
                              'searchString': searchController.text,
                            },
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.search,
                          size: 20,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      Get.toNamed(
                        SearchScreen.id,
                        arguments: {
                          'searchString': searchController.text,
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
