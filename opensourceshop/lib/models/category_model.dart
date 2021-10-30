class Category {
  String id;
  String name;
  String image;

  Category.fromJson(var jsonData) {
    this.id = jsonData['_id'];
    this.name = jsonData['name'];
    this.image = jsonData['image'];
  }
}
