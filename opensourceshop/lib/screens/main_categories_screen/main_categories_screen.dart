import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/models/category_model.dart';
import 'package:opensourceshop/screens/sub_categories_screen/sub_categories_screen.dart';
import 'package:opensourceshop/screens/widgets/category_widget.dart';
import 'package:opensourceshop/screens/widgets/main_app_bar.dart';
import 'package:opensourceshop/screens/widgets/main_bottom_bar.dart';

class MainCategoriesScreen extends StatelessWidget {
  static String id = '/mainCategoriesScreen';

  Future<List<Category>> getMainCategories() async {
    List<Category> categories = [];
    try {
      Dio dio = Dio();
      final response = await dio.get(
          'https://opensourceshop-app-control-panel.herokuapp.com/api/v1/category');
      response.data.forEach((category) {
        categories.add(Category.fromJson(category));
      });
    } catch (e) {
      print(e);
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: getMainCategories(),
            builder: (context, AsyncSnapshot<List<Category>> data) {
              if (data.hasData) {
                return Column(
                  children: [
                    MainAppBar(
                      showSearch: true,
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return CategoryWidget(
                            onTap: () => Get.toNamed(
                              SubCategoriesScreen.id,
                              arguments: {
                                'categoryId': data.data[index].id,
                              },
                            ),
                            title: data.data[index].name,
                            image: data.data[index].image,
                          );
                        },
                        itemCount: data.data.length,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   childAspectRatio: 1,
                        //   mainAxisSpacing: 10,
                        //   crossAxisSpacing: 10,
                        // ),
                      ),
                    ),
                    Divider(),
                    MainBottomBar(),
                  ],
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
