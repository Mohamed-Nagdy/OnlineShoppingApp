class SubCategory{
  String id;
  String name;
  String image;
  String category;

  SubCategory.fromJson(var jsonData){
    this.id = jsonData['_id'];
    this.name = jsonData['name'];
    this.image = jsonData['image'];
    this.category = jsonData['category'];
  }
}