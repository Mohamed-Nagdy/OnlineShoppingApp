import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nada_control_panel/models/category_model.dart';

import '../../constants.dart';

class AddSubCategoryScreen extends StatefulWidget {
  static String id = '/addSubCategoryScreen';

  @override
  _AddSubCategoryScreenState createState() => _AddSubCategoryScreenState();
}

class _AddSubCategoryScreenState extends State<AddSubCategoryScreen> {
  File _image;

  final picker = ImagePicker();
  String categoryId = '';
  String category = 'Choose Category';
  bool firstTime = false;

  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController categoryName = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<List<Category>> getAllCategories() async {
    List<Category> categories = [];
    // categories.clear();
    Dio dio = new Dio();
    try {
      String url = GET_ALL_CATEGORIES;
      var response = await dio.get(
        url,
      );
      var decodedResponse = response.data;
      if (response.statusCode == 200) {
        decodedResponse.forEach((vendor) {
          categories.add(Category.fromJson(vendor));
        });
      } else {
        Get.defaultDialog(
          title: 'Error',
          middleText: decodedResponse['msg'],
        );
      }
    } catch (e) {
      print(e);
    }
    return Future.value(categories);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Sub Category',
          ),
        ),
        body: FutureBuilder(
          future: getAllCategories(),
          builder: (context, AsyncSnapshot<List<Category>> data) {
            if (data.hasData) {
              return Container(
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
                                            image: _image == null
                                                ? null
                                                : DecorationImage(
                                                    image: FileImage(_image),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Category '),
                                    DropdownButton(
                                      hint: Text(
                                        category,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          categoryId = value.id;
                                          category = value.name;
                                        });
                                      },
                                      items: [
                                        ...data.data.map((item) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              item.name,
                                            ),
                                            value: item,
                                          );
                                        }).toList()
                                      ],
                                    ),
                                  ],
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
                                            "Choose Image First",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      try {
                                        final file =
                                            File(_image.path).readAsBytesSync();

                                        var response = await dio.post(
                                          CREATE_SUB_CATEGORY,
                                          data: {
                                            "name": categoryName.text,
                                            "category": categoryId,
                                            "image": base64Encode(file),
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
                                              "Created Successfully",
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
                                      'Create',
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