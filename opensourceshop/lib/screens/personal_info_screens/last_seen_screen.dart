import 'package:flutter/material.dart';
import 'package:opensourceshop/screens/widgets/fav_widget.dart';
import 'package:opensourceshop/screens/widgets/main_bottom_bar.dart';
import '../../screens/widgets/main_app_bar.dart';

class LastSeenScreen extends StatelessWidget {
  static String id = '/lastSeenScreen';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                MainAppBar(),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    itemBuilder: (context, index) {
                      return FavWidget();
                    },
                    itemCount: 5,
                  ),
                ),
                Divider(),
                MainBottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
