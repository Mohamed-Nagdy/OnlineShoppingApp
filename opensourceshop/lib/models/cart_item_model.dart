import 'package:opensourceshop/models/product_model.dart';

class CartItem {
  String id;
  int count;
  double price;
  Product product;
  String option1;
  String option2;

  CartItem.fromJson(var jsonData) {
    this.id = jsonData['_id'];
    this.count = jsonData['count'];
    this.price = double.parse(jsonData['price'].toString());
    this.product = Product.fromJson(jsonData['product']);
    this.option1 = jsonData['option1'];
    this.option2 = jsonData['option2'];
  }
}
