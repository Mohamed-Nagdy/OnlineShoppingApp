import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nada_control_panel/constants.dart';
import 'package:nada_control_panel/models/category_model.dart';
import 'package:nada_control_panel/screens/main_categories_screens/update_main_category_screen.dart';
import 'package:nada_control_panel/widgets/my_drawer.dart';

import 'add_new_category.dart';

class MainCategoriesScreen extends StatefulWidget {
  static String id = '/mainCategoriesScreen';

  @override
  _MainCategoriesScreenState createState() => _MainCategoriesScreenState();
}

class _MainCategoriesScreenState extends State<MainCategoriesScreen> {
  Future<List<Category>> getAllCategories() async {
    List<Category> categories = [];

    Dio dio = new Dio();
    try {
      String url = GET_ALL_CATEGORIES;
      var response = await dio.get(
        url,
      );
      var decodedResponse = response.data;
      // print(decodedResponse);
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.toNamed(AddNewCategory.id);
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
            'Main Categories',
          ),
        ),
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        body: Container(
          child: FutureBuilder(
            future: getAllCategories(),
            builder: (context, AsyncSnapshot<List<Category>> data) {
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
                    // Uint8List bytes = base64Decode(data.data[index].image);
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                data.data[index].image ?? '',
                                fit: BoxFit.fill,
                                width: Get.width,
                              ),
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
                                            BASE_URL +
                                                '/api/v1/category/${data.data[index].id}',
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
                                    UpdateMainCategiryScreen.id,
                                    arguments: {
                                      'category': data.data[index],
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
