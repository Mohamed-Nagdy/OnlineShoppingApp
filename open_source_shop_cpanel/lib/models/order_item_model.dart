class OrderItem {
  int count;
  double price;
  String id;
  String option1;
  String option2;
  String name;
  String image;

  OrderItem.fromJson(var jsonData) {
    this.count = jsonData['count'];
    this.price = double.parse(jsonData['price'].toString());
    this.id = jsonData['_id'];
    this.option1 = jsonData['option1'];
    this.option2 = jsonData['option2'];
    this.name = jsonData['product']['name'];
    this.image = jsonData['product']['image'];
  }
}
