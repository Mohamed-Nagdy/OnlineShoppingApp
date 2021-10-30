import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nada_control_panel/models/message.dart';
import 'package:nada_control_panel/widgets/text_input_widget.dart';

import '../../constants.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  static String id = '/chatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  Timer timer;
  ScrollController listController = ScrollController();

  Dio dio = Dio();
  final userId = Get.arguments['userId'];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => setTheState());
    Future.delayed(const Duration(seconds: 3), () {
      listController.animateTo(
        listController.position.maxScrollExtent + 100,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  void setTheState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<List<Message>> getMessages() async {
    List<Message> messages = [];
    try {
      final response = await dio.get(BASE_URL + '/api/v1/messages/$userId');
      response.data['messages'].forEach((product) {
        messages.add(Message.fromJson(product));
      });
    } catch (e) {
      print(e);
    }
    return messages;
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
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getMessages(),
                builder: (context, AsyncSnapshot<List<Message>> data) {
                  if (data.hasData) {
                    // print(data.data);

                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              controller: listController,
                              padding: const EdgeInsets.all(10),
                              itemCount: data.data.length,
                              itemBuilder: (context, index) {
                                return data.data[index].sender == 'admin'
                                    ? Container(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(MAIN_COLOR),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            data.data[index].message,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color(MAIN_COLOR),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            data.data[index].message,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextInputWidget(
                                    controller: messageController,
                                    title: '',
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: Get.width * 0.01,
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      if (messageController.text.isEmpty) {
                                        return;
                                      }
                                      try {
                                        await dio.post(
                                            BASE_URL +
                                                '/api/v1/messages/$userId',
                                            data: {
                                              'sender': 'admin',
                                              'message': messageController.text,
                                              'isNewMessage': false,
                                            });
                                        setState(() {
                                          data.data.add(
                                            Message(
                                              sender: 'admin',
                                              message: messageController.text,
                                            ),
                                          );
                                          messageController.clear();
                                          listController.animateTo(
                                            listController
                                                    .position.maxScrollExtent +
                                                100,
                                            curve: Curves.easeOut,
                                            duration: const Duration(
                                                milliseconds: 300),
                                          );
                                        });
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    icon: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Icon(
                                        Icons.send,
                                        color: Color(MAIN_COLOR),
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
