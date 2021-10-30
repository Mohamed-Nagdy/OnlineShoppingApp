class AllMessagesModel {
  bool showBanner;
  String userId;
  String userName;
  String lastMessage;

  AllMessagesModel.fromJson(var jsonData) {
    this.showBanner = jsonData['isNewMessage'];
    this.userId = jsonData['_id'];
    this.userName = jsonData['userName'];
    this.lastMessage = jsonData['lastMessage'] ?? '';
  }
}
