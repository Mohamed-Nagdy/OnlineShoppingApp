import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nada_control_panel/screens/login_screen/login_screen.dart';
import 'package:nada_control_panel/screens/main_categories_screens/main_categories_screen.dart';
import 'package:nada_control_panel/screens/messages_screens/all_messages_screen.dart';
import 'package:nada_control_panel/screens/ordres_screens/all_orders_screen.dart';
import 'package:nada_control_panel/screens/products_screens/products_screen.dart';
import 'package:nada_control_panel/widgets/drawer_widget.dart';

class MyDrawer extends StatelessWidget {
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'images/logo.png',
                height: Get.height * 0.2,
              ),
              DrawerWidget(
                title: 'Main Categories',
                onTap: () => Get.toNamed(
                  MainCategoriesScreen.id,
                ),
              ),
              // DrawerWidget(
              //   title: 'Sub Categories',
              //   onTap: () => Get.toNamed(
              //     SubCategoriesScreen.id,
              //   ),
              // ),
              DrawerWidget(
                title: 'Products',
                onTap: () => Get.toNamed(
                  ProductsScreen.id,
                ),
              ),
              DrawerWidget(
                title: 'Orders',
                onTap: () => Get.toNamed(
                  AllOrdersScreen.id,
                ),
              ),
              DrawerWidget(
                title: 'Messages',
                onTap: () => Get.toNamed(
                  AllMessagesScreen.id,
                ),
              ),
              if (storage.read('loggedIn') == true)
                DrawerWidget(
                  title: 'Logout',
                  onTap: () {
                    storage.write('loggedIn', false);
                    Get.offAllNamed(LoginScreen.id);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
