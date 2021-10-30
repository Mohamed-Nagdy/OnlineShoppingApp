import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/models/category_model.dart';
import 'package:opensourceshop/models/product_model.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/single_product_screen/single_product_screen.dart';
import 'package:opensourceshop/screens/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  static String id = '/productsScreen';
  final Category category = Get.arguments['category'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              category.name,
            ),
            backgroundColor: Color(MAIN_COLOR),
          ),
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: provider.getAllProducts(category.id),
            builder: (context, AsyncSnapshot<List<Product>> data) {
              if (data.hasData) {
                return Column(
                  children: [
                    // MainAppBar(),
                    // Divider(),
                    // MainTopAppBar(
                    //   title: 'المنتجات',
                    // ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          return ProductWidget(
                            onTap: () => Get.toNamed(
                              SingleProductScreen.id,
                              arguments: {
                                'product': provider.products[index],
                              },
                            ),
                            title: provider.products[index].name,
                            price: provider.products[index].price,
                            image: provider.products[index].image,
                            id: provider.products[index].id,
                          );
                        },
                        itemCount: provider.products.length,
                      ),
                    ),
                    // Divider(),
                    // MainBottomBar(),
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
