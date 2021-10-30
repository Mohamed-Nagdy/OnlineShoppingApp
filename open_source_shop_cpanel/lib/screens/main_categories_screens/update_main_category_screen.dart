import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class UpdateMainCategiryScreen extends StatefulWidget {
  static String id = '/updateMainCategoryScreen';
  @override
  _UpdateMainCategiryScreenState createState() =>
      _UpdateMainCategiryScreenState();
}

class _UpdateMainCategiryScreenState extends State<UpdateMainCategiryScreen> {
  Uint8List _image;
  String id;
  String oldImage;

  final picker = ImagePicker();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController categoryName = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path).readAsBytesSync();
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    oldImage = Get.arguments['category'].image;
    categoryName = TextEditingController(text: Get.arguments['category'].name);
    id = Get.arguments['category'].id;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Update Main Category',
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            top: 50,
            right: 10,
            left: 10,
          ),
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: InkWell(
                              onTap: getImage,
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height * 0.3,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      image: DecorationImage(
                                        image: _image == null
                                            ? NetworkImage(oldImage ?? '')
                                            : MemoryImage(_image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 30,
                                    left: Get.width * 0.3,
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      size: Get.width * 0.3,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 30,
                                    left: Get.width * 0.37,
                                    child: Text(
                                      'Picture',
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontSize: Get.width * 0.05,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: TextFormField(
                              controller: categoryName,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Enter Category Name First";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {},
                              decoration: InputDecoration(
                                hintText: "Category Name",
                                filled: true,
                                fillColor: Color(0XFFF2F2F2),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Get.dialog(
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                              if (key.currentState.validate()) {
                                key.currentState.save();
                                Dio dio = Dio();
                                if (_image == null) {
                                  var response = await dio.patch(
                                    BASE_URL + '/api/v1/category/$id',
                                    data: {
                                      "name": categoryName.text,
                                      "image": '',
                                    },
                                  );
                                  // print(response);
                                  if (response.statusCode == 200) {
                                    Get.back();
                                    Get.defaultDialog(
                                      title: "Done",
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.back();
                                          },
                                          child: Text(
                                            "OK",
                                          ),
                                        ),
                                      ],
                                      content: Text(
                                        "Updated Successfully",
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Get.back();
                                    Get.defaultDialog(
                                      title: "Error",
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text(
                                            "OK",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                      content: Text(
                                        "Error Happened Please Try Again Later",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  try {
                                    final file = _image;

                                    var response = await dio.patch(
                                      BASE_URL + '/api/v1/category/$id',
                                      data: {
                                        "name": categoryName.text,
                                        "image": 'data:image/png;base64,' +
                                            base64Encode(file),
                                      },
                                    );

                                    if (response.statusCode == 200) {
                                      Get.back();
                                      Get.defaultDialog(
                                        title: "Done",
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.back();
                                            },
                                            child: Text(
                                              "OK",
                                            ),
                                          ),
                                        ],
                                        content: Text(
                                          "Updated Successfully",
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Get.back();
                                      Get.defaultDialog(
                                        title: "Error",
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Text(
                                              "OK",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                        content: Text(
                                          "Error Happened Please Try Again Later",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print(e);
                                    Get.back();
                                    Get.defaultDialog(
                                      title: "Error",
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text(
                                            'Ok',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                      content: Text(
                                        "Some Error Happened Please Try Again",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: Get.width * 0.5,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(MAIN_COLOR),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      offset: Offset(
                                        2.0,
                                        4.0,
                                      ),
                                    ),
                                  ]),
                              child: AutoSizeText(
                                'Update',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Get.width * 0.05,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
