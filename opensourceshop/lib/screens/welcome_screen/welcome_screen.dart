import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/main_screen/main_screen.dart';
import 'package:opensourceshop/web/main_screen_web/main_screen_web.dart';
import 'package:provider/provider.dart';

import '../../constatnts.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = '/welcomeScreen';
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final email = GetStorage().read('email');
      final password = GetStorage().read('password');
      try {
        bool isLogged = await userProvider.loginAndSignUpAndEdit(
          {
            "email": email,
            "password": password,
          },
          LOGIN,
        );
        if (isLogged) {
          print('number one');
          if (Get.width > 1000)
            Get.offAllNamed(MainScreenWeb.id);
          else
            Get.offAllNamed(MainScreen.id);
        } else {
          print('number two');
          if (Get.width > 1000) {
            print('number web');
            Get.offAllNamed(MainScreenWeb.id);
          } else {
            print('number mobile');
            Get.offAllNamed(MainScreen.id);
          }
        }
      } catch (e) {
        print('number three');
        print(e);
        if (Get.width > 1000)
          Get.offAllNamed(MainScreenWeb.id);
        else
          Get.offAllNamed(MainScreen.id);
      }
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: 250,
              height: 250,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
