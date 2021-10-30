import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nada_control_panel/constants.dart';
import 'package:nada_control_panel/models/user_orders_model.dart';
import 'package:nada_control_panel/screens/ordres_screens/order_details_screen.dart';
import 'package:nada_control_panel/widgets/my_drawer.dart';

class AllOrdersScreen extends StatefulWidget {
  static String id = '/allOrdersScreen';
  @override
  _AllOrdersScreenState createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  Future<List<UserOrders>> getOrders() async {
    List<UserOrders> orders = [];

    Dio dio = new Dio();
    try {
      String url = GET_ORDERS;
      var response = await dio.get(
        url,
      );
      var decodedResponse = response.data;
      print(decodedResponse);
      if (response.statusCode == 200) {
        decodedResponse.forEach((vendor) {
          orders.add(UserOrders.fromJson(vendor));
        });
      } else {
        Get.defaultDialog(
          title: 'Error',
          middleText: decodedResponse['msg'],
        );
      }
    } catch (e) {
      print(e);
    }
    return Future.value(orders);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Orders',
          ),
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
          future: getOrders(),
          builder: (context, AsyncSnapshot<List<UserOrders>> data) {
            if (data.hasData) {
              return ListView.builder(
                itemCount: data.data.length,
                itemBuilder: (context, index) {
                  return data.data[index].orders.length != 0
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[400],
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User Name : ${data.data[index].userName}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'User Email : ${data.data[index].email}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'User Phone : ${data.data[index].phone}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Address : ${data.data[index].address ?? ''}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              ...data.data[index].orders.map((order) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[400],
                                        blurRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      await Get.toNamed(
                                        OrderDetailsScreen.id,
                                        arguments: {
                                          "order": order,
                                          "userId": data.data[index].id,
                                        },
                                      );
                                      setState(() {});
                                    },
                                    dense: true,
                                    isThreeLine: true,

                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                                    title: Text(
                                      'Date : ${order.createdAt}',
                                    ),
                                    subtitle: Text(
                                      'Total Price ${order.totalPrice} \n Order Status : ${order.status}',
                                    ),

                                    contentPadding: EdgeInsets.all(15),
                                    // leading: Image.memory(order),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        )
                      : Container();
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
