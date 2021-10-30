class User {
  String id;
  String name;
  String email;
  String address;
  String password;
  String phone;
  String deliveryAddress;
  String jwt;

  User();

  User.fromJson(var jsonData) {
    this.id = jsonData['_id'];
    this.name = jsonData['userName'];
    this.address = jsonData['address'];
    this.email = jsonData['email'];
    this.phone = jsonData['phone'];
    this.deliveryAddress = jsonData['deliverAddress'];
    this.jwt = jsonData['jwt'];
  }
}
