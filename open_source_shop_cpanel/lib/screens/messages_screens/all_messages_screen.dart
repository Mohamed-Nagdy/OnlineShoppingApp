import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nada_control_panel/models/all_messages_model.dart';
import 'package:nada_control_panel/screens/messages_screens/chat_screen.dart';
import 'package:nada_control_panel/widgets/my_drawer.dart';

import '../../constants.dart';

class AllMessagesScreen extends StatefulWidget {
  static String id = '/allMessagesScreen';

  @override
  _AllMessagesScreenState createState() => _AllMessagesScreenState();
}

class _AllMessagesScreenState extends State<AllMessagesScreen> {
  Future<List<AllMessagesModel>> getAllMessages() async {
    List<AllMessagesModel> messages = [];

    Dio dio = new Dio();
    try {
      String url = GET_ALL_USERS_MESSAGES;
      var response = await dio.get(
        url,
      );
      var decodedResponse = response.data;
      print(decodedResponse);
      if (response.statusCode == 200) {
        decodedResponse.forEach((vendor) {
          messages.add(AllMessagesModel.fromJson(vendor));
        });
      } else {
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Please Try Again Later',
        );
      }
    } catch (e) {
      print(e);
    }
    return Future.value(messages);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Messages',
          ),
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
          future: getAllMessages(),
          builder: (context, AsyncSnapshot<List<AllMessagesModel>> data) {
            if (data.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: data.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: ListTile(
                      onTap: () async {
                        await Get.toNamed(
                          ChatScreen.id,
                          arguments: {
                            'userId': data.data[index].userId,
                          },
                        );
                        setState(() {});
                      },
                      contentPadding: EdgeInsets.all(10),
                      title: Text(
                        data.data[index].userName,
                      ),
                      subtitle: Text(
                        data.data[index].lastMessage,
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                        onPressed: () {
                          try {
                            Get.defaultDialog(
                              title: 'Delete Item',
                              middleText: 'Are You Sure To Delete This Chat',
                              confirm: TextButton(
                                onPressed: () async {
                                  Get.dialog(
                                    Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                  Dio dio = Dio();
                                  await dio.delete(
                                    BASE_URL +
                                        '/api/v1/messages/${data.data[index].userId}',
                                  );
                                  setState(() {});
                                  Get.back();
                                  Get.back();
                                },
                                child: Text(
                                  'Yes',
                                ),
                              ),
                              cancel: TextButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  'No',
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                            Get.back();
                          }
                        },
                      ),
                      trailing: data.data[index].showBanner
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              height: 10,
                              width: 10,
                              child: Container(),
                            )
                          : null,
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
