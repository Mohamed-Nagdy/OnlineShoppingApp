class Message {
  String sender;
  String message;

  Message.fromJson(var jsonData) {
    this.sender = jsonData['sender'];
    this.message = jsonData['message'];
  }

  Message({this.sender, this.message});
}
