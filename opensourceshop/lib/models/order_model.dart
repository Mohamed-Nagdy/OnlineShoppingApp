class Order {
  String id;
  String status;
  double totalPrice;
  String name;
  String address;
  String phone;
  String date;

  Order.fromJson(var jsonData) {
    this.id = jsonData['_id'];
    this.status = jsonData['status'];
    this.totalPrice = double.parse(jsonData['totalPrice'].toString());
    this.name = jsonData['name'];
    this.address = jsonData['address'];
    this.phone = jsonData['phone'];
    this.date = jsonData['createdAt'];
  }
}
