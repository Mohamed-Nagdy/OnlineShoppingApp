import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/models/single_order_model.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../constatnts.dart';

class SingleBillScreen extends StatelessWidget {
  static String id = '/singleBillScreen';
  final orderId = Get.arguments['orderId'];
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'تفاصيل الطلب',
            ),
            backgroundColor: Color(MAIN_COLOR),
          ),
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: userProvider.getSingleOrder(orderId),
            builder: (context, AsyncSnapshot<SingleOrder> data) {
              if (data.hasData) {
                return Container(
                  child: Column(
                    children: [
                      // MainAppBar(),
                      // Divider(),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(10),
                          children: [
                            // item in cart
                            ...data.data.items.map((item) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  height: Get.height * 0.22,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: SHADOW,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: SHADOW,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              item.product.image,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        height: Get.height * 0.1,
                                        width: Get.height * 0.1,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.product.name,
                                            ),
                                            Text(
                                              item.option1,
                                            ),
                                            Text(
                                              item.option2,
                                            ),
                                            Text(
                                              '${item.price}' +
                                                  ' ' +
                                                  PRICE_SYMBOL,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color(0XFFE1E1E1),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'الإسم',
                                              style: TextStyle(
                                                color: Color(0XFF646464),
                                                fontSize: Get.width * 0.04,
                                              ),
                                            ),
                                            Text(
                                              data.data.name,
                                              style: TextStyle(
                                                fontSize: Get.width * 0.04,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'العنوان',
                                              style: TextStyle(
                                                color: Color(0XFF646464),
                                                fontSize: Get.width * 0.04,
                                              ),
                                            ),
                                            Text(
                                              data.data.address,
                                              style: TextStyle(
                                                fontSize: Get.width * 0.04,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'رقم الهاتف',
                                              style: TextStyle(
                                                color: Color(0XFF646464),
                                                fontSize: Get.width * 0.04,
                                              ),
                                            ),
                                            Text(
                                              data.data.phone,
                                              style: TextStyle(
                                                fontSize: Get.width * 0.04,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   margin: const EdgeInsets.symmetric(
                                      //     vertical: 15,
                                      //   ),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Text(
                                      //         ' التوصيل',
                                      //         style: TextStyle(
                                      //           color: Color(0XFF646464),
                                      //           fontSize: Get.width * 0.04,
                                      //         ),
                                      //       ),
                                      //       Text(
                                      //         '${data.data.deliverPrice}' +
                                      //             ' ' +
                                      //             'شيكل',
                                      //         style: TextStyle(
                                      //           fontSize: Get.width * 0.04,
                                      //           fontWeight: FontWeight.bold,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'سعر الشراء',
                                              style: TextStyle(
                                                color: Color(0XFF646464),
                                                fontSize: Get.width * 0.04,
                                              ),
                                            ),
                                            Text(
                                              '${data.data.totalPrice}' +
                                                  ' ' +
                                                  PRICE_SYMBOL,
                                              style: TextStyle(
                                                fontSize: Get.width * 0.04,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: Divider(
                                          thickness: 2,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'الإجمالي',
                                              style: TextStyle(
                                                color: Color(0XFF646464),
                                                fontSize: Get.width * 0.05,
                                              ),
                                            ),
                                            Text(
                                              '${data.data.totalPrice}' +
                                                  ' ' +
                                                  PRICE_SYMBOL,
                                              style: TextStyle(
                                                fontSize: Get.width * 0.05,
                                                fontWeight: FontWeight.bold,
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
          ),
        ),
      ),
    );
  }
}
