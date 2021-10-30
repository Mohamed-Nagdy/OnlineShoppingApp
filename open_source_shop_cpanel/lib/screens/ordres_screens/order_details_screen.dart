import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:nada_control_panel/models/single_order_model.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class OrderDetailsScreen extends StatelessWidget {
  static String id = '/orderDetailsScreen';
  final SingleOrder singleOrder = Get.arguments['order'];
  final TextEditingController orderState =
      TextEditingController(text: Get.arguments['order'].status);
  final userId = Get.arguments['userId'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Single Order Screen',
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    if (orderState.text.isEmpty) {
                      return;
                    }
                    try {
                      Get.dialog(Center(
                        child: CircularProgressIndicator(),
                      ));
                      Dio dio = Dio();
                      await dio.post(
                        UPDATE_ORDER_STATE,
                        data: {
                          "userId": userId,
                          "orderId": singleOrder.id,
                          "status": orderState.text,
                        },
                      );
                      Get.back();
                    } catch (e) {
                      print(e);
                      Get.back();
                    }
                  },
                  child: Container(
                    width: Get.width * 0.4,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(MAIN_COLOR),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(
                              2.0,
                              4.0,
                            ),
                          ),
                        ]),
                    child: AutoSizeText(
                      'Change Order State',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.width * 0.04,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.right,
                    controller: orderState,
                    decoration: InputDecoration(
                      hintText: 'Order State',
                    ),
                  ),
                ),
              ],
            ),
            ...singleOrder.products.map((product) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: ListTile(
                  isThreeLine: true,
                  leading: Image.network(
                    product.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    product.name,
                  ),
                  subtitle: Text(
                    'Color : ${product.option1} \nSize : ${product.option2} \nCount : ${product.count} \nPrice : ${product.price}',
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
