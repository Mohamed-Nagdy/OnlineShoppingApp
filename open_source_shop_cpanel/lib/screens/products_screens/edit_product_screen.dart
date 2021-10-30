import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nada_control_panel/models/category_model.dart';
import 'package:nada_control_panel/models/product_model.dart';

import '../../constants.dart';

class EditProductScreen extends StatefulWidget {
  static String id = '/editProductScreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  Uint8List _image;
  Product product = Get.arguments['product'];

  final picker = ImagePicker();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option1Title = TextEditingController();
  TextEditingController option2Title = TextEditingController();
  List<dynamic> options1 = [];
  List<dynamic> options2 = [];
  String categoryId = '';
  String category = '';
  String oldImage;

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

  Future<List<Category>> getAllCategories() async {
    List<Category> categories = [];

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
        categories.forEach((element) {
          if (product.category == element.id) {
            print('yes');
            setState(() {
              category = element.name;
              categoryId = element.id;
            });
          }
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
  void initState() {
    oldImage = product.image;
    name = TextEditingController(text: product.name);
    description = TextEditingController(text: product.description);
    price = TextEditingController(text: product.price.toString());
    options1 = product.options1;
    options2 = product.options2;
    option1Title = TextEditingController(text: product.option1Title);
    option2Title = TextEditingController(text: product.option2Title);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add New Product',
          ),
        ),
        body: FutureBuilder(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  ? NetworkImage(oldImage)
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
                                    controller: name,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Product Name First";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Product Name",
                                      filled: true,
                                      fillColor: Color(0XFFF2F2F2),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: TextFormField(
                                    controller: price,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Price First";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {},
                                    decoration: InputDecoration(
                                      hintText: "Price",
                                      filled: true,
                                      fillColor: Color(0XFFF2F2F2),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: TextFormField(
                                    controller: description,
                                    maxLines: 5,
                                    minLines: 5,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Description First";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Product Description",
                                      filled: true,
                                      fillColor: Color(0XFFF2F2F2),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Category',
                                    ),
                                    DropdownButton(
                                      hint: Text(
                                        category,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          category = value.name;
                                          categoryId = value.id;
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
                                // add new color to colors list
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: TextFormField(
                                    controller: option1Title,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Options 1 Title First";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Option One Title",
                                      filled: true,
                                      fillColor: Color(0XFFF2F2F2),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (option1.text.isEmpty) {
                                            return;
                                          }
                                          setState(() {
                                            options1.add(option1.text);
                                            option1.clear();
                                          });
                                        },
                                        child: Container(
                                          width: Get.width * 0.3,
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                            'Add Options 1',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Get.width * 0.04,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: option1,
                                          decoration: InputDecoration(
                                            hintText: 'Option',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // show all colors
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  alignment: WrapAlignment.spaceEvenly,
                                  direction: Axis.horizontal,
                                  children: [
                                    ...options1.map((e) {
                                      return Container(
                                        // width: 100,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(
                                              MAIN_COLOR,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  options1.remove(e);
                                                });
                                              },
                                            ),
                                            Text(e),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                                // sizes
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: TextFormField(
                                    controller: option2Title,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Options Two Title First";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Options Two Title",
                                      filled: true,
                                      fillColor: Color(0XFFF2F2F2),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (option2.text.isEmpty) {
                                            return;
                                          }
                                          setState(() {
                                            options2.add(option2.text);
                                            option2.clear();
                                          });
                                        },
                                        child: Container(
                                          width: Get.width * 0.3,
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                            'Add Options 2',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Get.width * 0.04,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: option2,
                                          decoration: InputDecoration(
                                            hintText: 'Option',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceEvenly,
                                  children: [
                                    ...options2.map((e) {
                                      return Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(
                                              MAIN_COLOR,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  options2.remove(e);
                                                });
                                              },
                                            ),
                                            Text(e),
                                          ],
                                        ),
                                      );
                                    }).toList(),
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
                                        try {
                                          var response = await dio.patch(
                                            UPDATE_PRODUCT + product.id,
                                            data: {
                                              "name": name.text,
                                              "image": '',
                                              "description": description.text,
                                              "category": categoryId,
                                              "optionOne": {
                                                'title': option1Title.text,
                                                'options': options1,
                                              },
                                              "optionTwo": {
                                                'title': option2Title.text,
                                                'options': options2,
                                              },
                                              "price": double.parse(price.text),
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
                                      } else {
                                        try {
                                          final file = _image;

                                          var response = await dio.patch(
                                            UPDATE_PRODUCT + product.id,
                                            data: {
                                              "name": name.text,
                                              "image":
                                                  'data:image/png;base64,' +
                                                      base64Encode(file),
                                              "description": description.text,
                                              "category": categoryId,
                                              "optionOne": {
                                                'title': option1Title.text,
                                                'options': options1,
                                              },
                                              "optionTwo": {
                                                'title': option2Title.text,
                                                'options': options2,
                                              },
                                              "price": double.parse(price.text),
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
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: getAllCategories(),
        ),
      ),
    );
  }
}
