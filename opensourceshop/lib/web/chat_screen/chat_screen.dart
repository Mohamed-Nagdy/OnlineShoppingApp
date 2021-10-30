import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/models/message.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/web/widgets/text_input_widget.dart';
import 'package:provider/provider.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreenWeb extends StatefulWidget {
  static String id = '/chatScreenWeb';

  @override
  _ChatScreenWebState createState() => _ChatScreenWebState();
}

class _ChatScreenWebState extends State<ChatScreenWeb> {
  TextEditingController messageController = TextEditingController();
  Timer timer;
  ScrollController listController = ScrollController();

  Dio dio = Dio();

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
    final provider = Provider.of<UserProvider>(context, listen: false);
    List<Message> messages = [];
    try {
      final response = await dio.get(USER_MESSAGES + provider.user.id);
      response.data['messages'].forEach((product) {
        messages.add(Message.fromJson(product));
      });
    } catch (e) {
      print(e);
    }
    return messages;
  }

  // @override
  // void initState() {
  //   try {
  //     IO.Socket socket = IO.io(
  //         'http://192.168.1.5:3600',
  //         IO.OptionBuilder()
  //             .disableAutoConnect()
  //             .setTransports(['websocket']).build());
  //     socket.connect();
  //     socket.on('connect', (data) => print('connected'));
  //     socket.on('connect_error',
  //         (data) => print('connect errror ' + data.toString()));
  //     socket.on('connect_timeout',
  //         (data) => print('connect time out ' + data.toString()));
  //   } catch (e) {
  //     print('error ' + e);
  //   }

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'مراسلتنا',
            ),
            backgroundColor: Color(MAIN_COLOR),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // MainAppBar(),
              // Divider(),
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
                                controller: listController,
                                padding: const EdgeInsets.all(10),
                                itemCount: data.data.length,
                                itemBuilder: (context, index) {
                                  return data.data[index].sender == 'user'
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 20.sp,
                                    ),
                                    child: IconButton(
                                      onPressed: () async {
                                        if (messageController.text.isEmpty) {
                                          return;
                                        }
                                        try {
                                          await dio.post(
                                              USER_MESSAGES + provider.user.id,
                                              data: {
                                                'sender': 'user',
                                                'message':
                                                    messageController.text,
                                                'isNewMessage': true,
                                              });
                                          setState(() {
                                            data.data.add(
                                              Message(
                                                sender: 'user',
                                                message: messageController.text,
                                              ),
                                            );

                                            messageController.clear();
                                            listController.animateTo(
                                              listController.position
                                                      .maxScrollExtent +
                                                  100,
                                              curve: Curves.easeOut,
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
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
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextInputWidget(
                                        hint: '..... اكتب رسالتك',
                                        controller: messageController,
                                        title: '',
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
              // Divider(),
              // MainBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
