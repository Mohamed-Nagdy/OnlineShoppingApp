import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nada_control_panel/constants.dart';
import 'package:nada_control_panel/models/sub_category_model.dart';
import 'package:nada_control_panel/screens/sub_categories_screens/update_sub_category_screen.dart';
import 'package:nada_control_panel/widgets/my_drawer.dart';

import 'add_sub_category_screen.dart';

class SubCategoriesScreen extends StatefulWidget {
  static String id = '/subCategoryScreen';

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  Future<List<SubCategory>> getAllCategories() async {
    List<SubCategory> subCategories = [];

    Dio dio = new Dio();
    try {
      String url = GET_SUB_CATEGORIES;
      var response = await dio.get(
        url,
      );
      var decodedResponse = response.data;
      // print(decodedResponse);
      if (response.statusCode == 200) {
        decodedResponse.forEach((vendor) {
          subCategories.add(SubCategory.fromJson(vendor));
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
    return Future.value(subCategories);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.toNamed(AddSubCategoryScreen.id);
            setState(() {});
          },
          child: Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.refresh,
                ),
                onPressed: () {
                  setState(() {});
                }),
          ],
          title: Text(
            'Sub Categories',
          ),
        ),
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        body: Container(
          child: FutureBuilder(
            future: getAllCategories(),
            builder: (context, data) {
              if (data.hasData) {
                return GridView.builder(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    Uint8List bytes = base64Decode(data.data[index].image);
                    // String string = String.fromCharCodes(bytes);
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 2,
                            offset: Offset(
                              2.0,
                              4.0,
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.memory(
                              bytes,
                              fit: BoxFit.fill,
                              width: Get.width,
                            ),
                          ),
                          Text(
                            data.data[index].name,
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  try {
                                    Get.defaultDialog(
                                      title: 'Delete Item',
                                      middleText:
                                          'Are You Sure To Delete This Item',
                                      confirm: TextButton(
                                        onPressed: () async {
                                          Get.dialog(
                                            Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                          Dio dio = Dio();
                                          await dio.delete(
                                            'https://nada-app-control-panel.herokuapp.com/api/v1/subCategory/${data.data[index].id}',
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
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () async {
                                  await Get.toNamed(
                                    UpdateSubCategoryScreen.id,
                                    arguments: {
                                      'subcategory': data.data[index],
                                    },
                                  );
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: data.data.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
