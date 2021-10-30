import 'package:nada_control_panel/models/single_order_model.dart';

class UserOrders {
  String id;
  String userName;
  String email;
  String phone;
  String address;
  List<SingleOrder> orders = [];

  UserOrders.fromJson(var jsonData) {
    this.id = jsonData['_id'];
    this.userName = jsonData['userName'];
    this.email = jsonData['email'];
    this.address = jsonData['address'];
    this.phone = jsonData['phone'];
    jsonData['orders'].forEach((order) {
      orders.add(SingleOrder.fromJson(order));
    });
  }
}
