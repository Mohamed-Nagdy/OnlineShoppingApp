import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/models/product_model.dart';
import 'package:opensourceshop/screens/single_product_screen/single_product_screen.dart';
import 'package:opensourceshop/screens/widgets/main_app_bar.dart';
import 'package:opensourceshop/screens/widgets/main_bottom_bar.dart';
import 'package:opensourceshop/screens/widgets/product_widget.dart';

class SearchScreen extends StatelessWidget {
  static String id = '/searchScreen';
  final searchString = Get.arguments['searchString'];

  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    try {
      Dio dio = Dio();
      final response = await dio.post(
        'https://opensourceshop-app-control-panel.herokuapp.com/api/v1/products/search',
        data: {
          'searchString': searchString,
        },
      );
      response.data.forEach((product) {
        products.add(Product.fromJson(product));
      });
    } catch (e) {
      print(e);
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: getAllProducts(),
            builder: (context, AsyncSnapshot<List<Product>> data) {
              if (data.hasData) {
                return Column(
                  children: [
                    MainAppBar(),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ProductWidget(
                            onTap: () => Get.toNamed(
                              SingleProductScreen.id,
                              arguments: {
                                'product': data.data[index],
                              },
                            ),
                            title: data.data[index].name,
                            price: data.data[index].price,
                            image: data.data[index].image,
                            id: data.data[index].id,
                          );
                        },
                        itemCount: data.data.length,
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
