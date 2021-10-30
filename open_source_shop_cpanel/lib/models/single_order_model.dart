import 'package:nada_control_panel/models/order_item_model.dart';

class SingleOrder {
  String id;
  String status;
  int itemsCount;
  double totalPrice;
  String createdAt;
  List<OrderItem> products = [];

  SingleOrder.fromJson(var jsonData) {
    this.id = jsonData['_id'];
    this.status = jsonData['status'];
    this.itemsCount = jsonData['itemsCount'];
    this.totalPrice = double.parse(jsonData['totalPrice'].toString());
    this.createdAt = jsonData['createdAt'];
    jsonData['items'].forEach((orderItem) {
      this.products.add(OrderItem.fromJson(orderItem));
    });
  }
}
