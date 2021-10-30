import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/about_us_screen/about_us_screen.dart';
import 'package:opensourceshop/screens/bill_screen/bill_screen.dart';
import 'package:opensourceshop/screens/chat_screen/chat_screen.dart';
import 'package:opensourceshop/screens/login_and_signup_screen/login_and_singup_screen.dart';
import 'package:opensourceshop/screens/main_app_screen/main_app_screen.dart';
import 'package:opensourceshop/screens/main_categories_screen/main_categories_screen.dart';
import 'package:opensourceshop/screens/main_screen/main_screen.dart';
import 'package:opensourceshop/screens/my_bills_screen/my_bills_screen.dart';
import 'package:opensourceshop/screens/my_bills_screen/single_bill_screen.dart';
import 'package:opensourceshop/screens/personal_info_screens/all_personal_info_screens.dart';
import 'package:opensourceshop/screens/personal_info_screens/fill_bill_info.dart';
import 'package:opensourceshop/screens/personal_info_screens/last_seen_screen.dart';
import 'package:opensourceshop/screens/personal_info_screens/order_submitted_screen.dart';
import 'package:opensourceshop/screens/products_screen/products_screen.dart';
import 'package:opensourceshop/screens/search_screen/search_screen.dart';
import 'package:opensourceshop/screens/single_product_screen/single_product_screen.dart';
import 'package:opensourceshop/screens/sub_categories_screen/sub_categories_screen.dart';
import 'package:opensourceshop/screens/welcome_screen/welcome_screen.dart';

// web screens imports
import 'package:opensourceshop/web/about_us_screen/about_us_screen.dart';
import 'package:opensourceshop/web/bill_screen/bill_screen.dart';
import 'package:opensourceshop/web/chat_screen/chat_screen.dart';
import 'package:opensourceshop/web/login_and_signup_screen/login_and_singup_screen.dart';
import 'package:opensourceshop/web/main_categories_screen/main_categories_screen.dart';
import 'package:opensourceshop/web/my_bills_screen/my_bills_screen.dart';
import 'package:opensourceshop/web/my_bills_screen/single_bill_screen.dart';
import 'package:opensourceshop/web/personal_info_screens/all_personal_info_screens.dart';
import 'package:opensourceshop/web/personal_info_screens/fill_bill_info.dart';
import 'package:opensourceshop/web/personal_info_screens/last_seen_screen.dart';
import 'package:opensourceshop/web/personal_info_screens/order_submitted_screen.dart';
import 'package:opensourceshop/web/products_screen/products_screen.dart';
import 'package:opensourceshop/web/search_screen/search_screen.dart';
import 'package:opensourceshop/web/single_product_screen/single_product_screen.dart';
import 'package:opensourceshop/web/sub_categories_screen/sub_categories_screen.dart';
import 'package:opensourceshop/web/main_screen_web/main_screen_web.dart';

import 'package:provider/provider.dart';

import 'screens/main_screen/main_screen_tabs/cart_tab.dart';
import 'screens/main_screen/main_screen_tabs/fav_tab.dart';
import 'screens/main_screen/main_screen_tabs/profile_tab.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  await GetStorage.init();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.cairoTextTheme(
              Theme.of(context).textTheme,
            ),
            accentColor: Color(MAIN_COLOR),
          ),
          initialRoute: WelcomeScreen.id,
          routes: {
            WelcomeScreen.id: (context) => WelcomeScreen(),
            MainScreen.id: (context) => MainScreen(),
            MainAppScreen.id: (context) => MainAppScreen(),
            SubCategoriesScreen.id: (context) => SubCategoriesScreen(),
            ProductsScreen.id: (context) => ProductsScreen(),
            SingleProductScreen.id: (context) => SingleProductScreen(),
            MainCategoriesScreen.id: (context) => MainCategoriesScreen(),
            CartTab.id: (context) => CartTab(),
            AllPersonalInfoScreen.id: (context) => AllPersonalInfoScreen(),
            ProfileTab.id: (context) => ProfileTab(),
            FavTab.id: (context) => FavTab(),
            LastSeenScreen.id: (context) => LastSeenScreen(),
            OrderSubmittedScreen.id: (context) => OrderSubmittedScreen(),
            BillScreen.id: (context) => BillScreen(),
            AboutUsScreen.id: (context) => AboutUsScreen(),
            ChatScreen.id: (context) => ChatScreen(),
            MyBillsScreen.id: (context) => MyBillsScreen(),
            LoginAndSignUpScreen.id: (context) => LoginAndSignUpScreen(),
            FillBillInfo.id: (context) => FillBillInfo(),
            SingleBillScreen.id: (context) => SingleBillScreen(),
            SearchScreen.id: (context) => SearchScreen(),

            // web screens
            MainScreenWeb.id: (context) => MainScreenWeb(),
            SubCategoriesScreenWeb.id: (context) => SubCategoriesScreenWeb(),
            ProductsScreenWeb.id: (context) => ProductsScreenWeb(),
            SingleProductScreenWeb.id: (context) => SingleProductScreenWeb(),
            MainCategoriesScreenWeb.id: (context) => MainCategoriesScreenWeb(),
            AllPersonalInfoScreenWeb.id: (context) =>
                AllPersonalInfoScreenWeb(),
            LastSeenScreenWeb.id: (context) => LastSeenScreenWeb(),
            OrderSubmittedScreenWeb.id: (context) => OrderSubmittedScreenWeb(),
            BillScreenWeb.id: (context) => BillScreenWeb(),
            AboutUsScreenWeb.id: (context) => AboutUsScreenWeb(),
            ChatScreenWeb.id: (context) => ChatScreenWeb(),
            MyBillsScreenWeb.id: (context) => MyBillsScreenWeb(),
            LoginAndSignUpScreenWeb.id: (context) => LoginAndSignUpScreenWeb(),
            FillBillInfoWeb.id: (context) => FillBillInfoWeb(),
            SingleBillScreenWeb.id: (context) => SingleBillScreenWeb(),
            SearchScreenWeb.id: (context) => SearchScreenWeb(),
          },
        ),
      ),
    );
  }
}
