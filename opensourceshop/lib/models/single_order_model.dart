import 'package:opensourceshop/models/cart_item_model.dart';

class SingleOrder {
  String id;
  String status;
  double totalPrice = 0;
  String name;
  String address;
  String phone;
  String date;
  // double deliverPrice;
  List<CartItem> items = [];

  SingleOrder.fromJson(var jsonData) {
    this.id = jsonData['_id'];
    this.status = jsonData['status'];
    // this.totalPrice = double.parse(jsonData['totalPrice'].toString());

    this.name = jsonData['name'];
    this.address = jsonData['address'];
    this.phone = jsonData['phone'];
    this.date = jsonData['createdAt'];
    // this.deliverPrice = double.parse(jsonData['deliverPrice'].toString());

    jsonData['items'].forEach((item) {
      this.items.add(CartItem.fromJson(item));
      this.totalPrice += double.parse(item['price'].toString());
    });
  }
}
