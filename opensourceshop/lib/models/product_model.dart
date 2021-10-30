class Product {
  String id;
  String name;
  String description;
  double price;
  String image;
  String category;
  List<dynamic> options1 = [];
  List<dynamic> options2 = [];
  String title1;
  String title2;

  Product.fromJson(var jsonData) {
    this.id = jsonData['_id'];
    this.name = jsonData['name'];
    this.description = jsonData['description'];
    this.price = double.parse(jsonData['price'].toString());
    this.image = jsonData['image'];
    this.options1 = jsonData['optionOne']['options'];
    this.options2 = jsonData['optionTwo']['options'];
    this.title1 = jsonData['optionOne']['title'];
    this.title2 = jsonData['optionTwo']['title'];
    this.category = jsonData['category'];
  }
}
