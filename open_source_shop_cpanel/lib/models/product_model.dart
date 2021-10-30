class Product {
  String id;
  String name;
  String description;
  double price;
  String image;
  String category;
  String option1Title;
  String option2Title;
  List<dynamic> options1 = [];
  List<dynamic> options2 = [];

  Product.fromJson(var jsonData) {
    this.id = jsonData['_id'];
    this.name = jsonData['name'];
    this.description = jsonData['description'];
    this.price = double.parse(jsonData['price'].toString());
    this.image = jsonData['image'];
    this.option1Title = jsonData['optionOne']['title'];
    this.option2Title = jsonData['optionTwo']['title'];
    this.options1 = jsonData['optionOne']['options'];
    this.options2 = jsonData['optionTwo']['options'];
    this.category = jsonData['category'];
  }
}
