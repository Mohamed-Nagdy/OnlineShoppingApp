import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/models/order_model.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/my_bills_screen/single_bill_screen.dart';
import 'package:provider/provider.dart';

class MyBillsScreen extends StatelessWidget {
  static String id = '/myBillsScreen';

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'مشترياتي',
            ),
            backgroundColor: Color(MAIN_COLOR),
          ),
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: userProvider.getUserOrders(),
            builder: (context, AsyncSnapshot<List<Order>> data) {
              if (data.hasData) {
                return Container(
                  child: Column(
                    children: [
                      // MainAppBar(),
                      // Divider(),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Get.toNamed(
                                SingleBillScreen.id,
                                arguments: {
                                  'orderId': data.data[index].id,
                                },
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(1.0, 3.0),
                                      color: Colors.grey[400],
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'رقم الأوردر الخاص بك :  ${index + 1}',
                                      style: TextStyle(
                                        color: Color(MAIN_COLOR),
                                        fontSize: Get.width * 0.05,
                                      ),
                                    ),
                                    Text(
                                      'الحالة : ${data.data[index].status}',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: Get.width * 0.04,
                                      ),
                                    ),
                                    Text(
                                      'التكلفة : ${data.data[index].totalPrice} $PRICE_SYMBOL ',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: Get.width * 0.04,
                                      ),
                                    ),
                                    Text(
                                      'التاريخ : ${data.data[index].date}',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: Get.width * 0.04,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
