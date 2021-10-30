import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/models/category_model.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/products_screen/products_screen.dart';
import 'package:opensourceshop/screens/widgets/category_widget.dart';
import 'package:opensourceshop/screens/widgets/main_top_app_bar.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return FutureBuilder(
        future: provider.getCategories(),
        builder: (context, AsyncSnapshot<List<Category>> data) {
          if (data.hasData) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Image.asset(
                  //   'images/logo.png',
                  // ),
                  MainTopAppBar(
                    title: 'الرئيسية',
                  ),
                  Expanded(
                    child: ListView.builder(
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   crossAxisSpacing: 5,
                        //   mainAxisSpacing: 5,
                        //   childAspectRatio: 0.8,
                        // ),
                        itemCount: provider.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryWidget(
                            onTap: () => Get.toNamed(
                              ProductsScreen.id,
                              arguments: {
                                'category': provider.categories[index],
                              },
                            ),
                            title: provider.categories[index].name,
                            image: provider.categories[index].image,
                          );
                        }),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
