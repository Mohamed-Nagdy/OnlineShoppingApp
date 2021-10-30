import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/single_product_screen/single_product_screen.dart';
import 'package:opensourceshop/screens/widgets/fav_widget.dart';
import 'package:opensourceshop/screens/widgets/main_top_app_bar.dart';
import 'package:opensourceshop/screens/widgets/not_logged_in_widget.dart';
import 'package:provider/provider.dart';

class FavTab extends StatefulWidget {
  static String id = '/favTabScreen';

  @override
  _FavTabState createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: provider.isLoggedIn
              ? FutureBuilder(
                  future: provider.getFavourites(),
                  builder: (context, data) {
                    if (data.hasData) {
                      if (data.data.length == 0) {
                        return Column(
                          children: [
                            MainTopAppBar(
                              title: 'المفضلة',
                            ),
                            Expanded(
                              child: Center(
                                child: Container(
                                  child: Text(
                                    'لا توجد مفضلة',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          child: Column(
                            children: [
                              // MainAppBar(),
                              // Divider(),
                              MainTopAppBar(
                                title: 'المفضلة',
                              ),
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.8,
                                  ),
                                  // padding: EdgeInsets.only(
                                  //   top: 10,
                                  //   left: 10,
                                  //   right: 10,
                                  //   bottom: 10,
                                  // ),
                                  itemBuilder: (context, index) {
                                    return FavWidget(
                                      onTap: () async {
                                        await Get.toNamed(
                                          SingleProductScreen.id,
                                          arguments: {
                                            'product': data.data[index],
                                          },
                                        );
                                      },
                                      title: data.data[index].name,
                                      price: data.data[index].price,
                                      image: data.data[index].image,
                                      id: data.data[index].id,
                                      onHeartTap: () async {
                                        var userProvider =
                                            Provider.of<UserProvider>(
                                          context,
                                          listen: false,
                                        );
                                        await userProvider.removeFromFavourites(
                                          data.data[index].id,
                                        );
                                        setState(() {});
                                        setState(() {});
                                        setState(() {});
                                      },
                                    );
                                  },
                                  itemCount: data.data.length,
                                ),
                              ),
                              // Divider(),
                              // MainBottomBar(),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : NotLoggedInWidget(
                  title: 'انت غير مشترك سجل الدخول او اشترك حتى تستطيع الإكمال',
                ),
        ),
      ),
    );
  }
}
