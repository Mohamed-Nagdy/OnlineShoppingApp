import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nada_control_panel/constants.dart';
import 'package:nada_control_panel/screens/messages_screens/all_messages_screen.dart';
import 'package:nada_control_panel/screens/messages_screens/chat_screen.dart';
import 'package:nada_control_panel/screens/ordres_screens/all_orders_screen.dart';
import 'package:nada_control_panel/screens/ordres_screens/order_details_screen.dart';
import 'package:nada_control_panel/screens/products_screens/add_new_product_screen.dart';
import 'package:nada_control_panel/screens/products_screens/edit_product_screen.dart';
import 'package:nada_control_panel/screens/products_screens/products_screen.dart';
import 'package:nada_control_panel/screens/sub_categories_screens/update_sub_category_screen.dart';
import 'screens/login_screen/login_screen.dart';
import 'screens/main_categories_screens/add_new_category.dart';
import 'screens/main_categories_screens/main_categories_screen.dart';
import 'screens/main_categories_screens/update_main_category_screen.dart';
import 'screens/sub_categories_screens/add_sub_category_screen.dart';
import 'screens/sub_categories_screens/sub_categories_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
      theme: ThemeData(
          primaryColor: Color(MAIN_COLOR),
          accentColor: Color(MAIN_COLOR),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          )),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        MainCategoriesScreen.id: (context) => MainCategoriesScreen(),
        AddNewCategory.id: (context) => AddNewCategory(),
        SubCategoriesScreen.id: (context) => SubCategoriesScreen(),
        AddSubCategoryScreen.id: (context) => AddSubCategoryScreen(),
        UpdateMainCategiryScreen.id: (context) => UpdateMainCategiryScreen(),
        UpdateSubCategoryScreen.id: (context) => UpdateSubCategoryScreen(),
        ProductsScreen.id: (context) => ProductsScreen(),
        AddNewProductScreen.id: (context) => AddNewProductScreen(),
        EditProductScreen.id: (context) => EditProductScreen(),
        AllOrdersScreen.id: (context) => AllOrdersScreen(),
        OrderDetailsScreen.id: (context) => OrderDetailsScreen(),
        AllMessagesScreen.id: (context) => AllMessagesScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
