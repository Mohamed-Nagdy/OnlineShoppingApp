import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/models/cart_item_model.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/personal_info_screens/fill_bill_info.dart';
import 'package:opensourceshop/screens/widgets/cart_widget.dart';
import 'package:opensourceshop/screens/widgets/custom_button.dart';
import 'package:opensourceshop/screens/widgets/main_top_app_bar.dart';
import 'package:opensourceshop/screens/widgets/not_logged_in_widget.dart';
import 'package:provider/provider.dart';

class CartTab extends StatefulWidget {
  static String id = '/cartTabScreenWeb';

  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: userProvider.isLoggedIn
              ? FutureBuilder(
                  future: userProvider.getUserCart(),
                  builder: (context, AsyncSnapshot<List<CartItem>> data) {
                    if (data.hasData) {
                      return Container(
                        child: Column(
                          children: [
                            // MainAppBar(),
                            // Divider(),
                            MainTopAppBar(
                              title: 'العربة',
                            ),
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.all(10),
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...data.data.map((item) {
                                        return CartWidget(
                                          item: item,
                                          onRemovePressed: () async {
                                            await userProvider.removeFromCart(
                                              item.id,
                                            );
                                            setState(() {});
                                            setState(() {});
                                            setState(() {});
                                          },
                                        );
                                      }).toList(),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: Text(
                                          'إجمالي المشتريات',
                                          style: TextStyle(
                                            color: Color(0XFF646464),
                                            fontSize: Get.width * 0.05,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0XFFE1E1E1),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'سعر الشراء',
                                                    style: TextStyle(
                                                      color: Color(0XFF646464),
                                                      fontSize:
                                                          Get.width * 0.04,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${userProvider.totalPrice}' +
                                                        ' ' +
                                                        PRICE_SYMBOL,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Get.width * 0.04,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Container(
                                            //   margin:
                                            //       const EdgeInsets.symmetric(
                                            //     vertical: 15,
                                            //   ),
                                            //   child: Row(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment
                                            //             .spaceBetween,
                                            //     children: [
                                            //       Text(
                                            //         'التوصيل',
                                            //         style: TextStyle(
                                            //           color: Color(0XFF646464),
                                            //           fontSize:
                                            //               Get.width * 0.04,
                                            //         ),
                                            //       ),
                                            //       Text(
                                            //         '${userProvider.deliveryPrice}' +
                                            //             ' ' +
                                            //             PRICE_SYMBOL,
                                            //         style: TextStyle(
                                            //           fontSize:
                                            //               Get.width * 0.04,
                                            //           fontWeight:
                                            //               FontWeight.bold,
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              child: Divider(
                                                thickness: 2,
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'الإجمالي',
                                                    style: TextStyle(
                                                      color: Color(0XFF646464),
                                                      fontSize:
                                                          Get.width * 0.05,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${userProvider.totalPrice}' +
                                                        ' ' +
                                                        PRICE_SYMBOL,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Get.width * 0.05,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomButton(
                                    title: 'تأكيد البيانات',
                                    onTap: () => data.data.length == 0
                                        ? null
                                        : Get.toNamed(
                                            FillBillInfo.id,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            // Divider(),
                            // MainBottomBar(),
                          ],
                        ),
                      );
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
