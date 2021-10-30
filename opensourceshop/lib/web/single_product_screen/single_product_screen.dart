import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/models/product_model.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/web/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProductScreenWeb extends StatefulWidget {
  static String id = '/singleProductScreenWeb';

  @override
  _SingleProductScreenWebState createState() => _SingleProductScreenWebState();
}

class _SingleProductScreenWebState extends State<SingleProductScreenWeb> {
  String option1 = '', option2 = '';
  Product product = Get.arguments['product'];
  var image;
  var price;
  var description;
  var name;
  var options2;
  var options1;
  var title1;
  var title2;
  int count = 1;
  bool addedToCart = false;

  @override
  void initState() {
    option1 = product.options1[0];
    option2 = product.options2[0];
    image = product.image;
    price = product.price;
    description = product.description;
    name = product.name;
    options1 = product.options1;
    options2 = product.options2;
    title1 = product.title1;
    title2 = product.title2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              product.name,
            ),
            backgroundColor: Color(MAIN_COLOR),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // MainAppBar(),
              // Divider(),
              // MainTopAppBar(
              //   title: product.name,
              // ),
              Expanded(
                child: ListView.builder(
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  key: Key('ny new cky'),
                  itemBuilder: (context, data) {
                    return Column(
                      children: [
                        Image.network(
                          image,
                          fit: BoxFit.fill,
                          height: Get.height * 0.5,
                          width: Get.width,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(
                                        MAIN_COLOR,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'السعر $price' + ' ' + PRICE_SYMBOL,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'وصف المنتج',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(
                                    MAIN_COLOR,
                                  ),
                                ),
                              ),
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                title1,
                              ),
                              Wrap(
                                children: [
                                  ...options1.map((singleColors) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          option1 = singleColors;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          border: Border.all(
                                            color: option1 == singleColors
                                                ? Color(MAIN_COLOR)
                                                : Colors.black,
                                          ),
                                        ),
                                        child: Text(
                                          singleColors,
                                          style: TextStyle(
                                            color: option1 == singleColors
                                                ? Color(MAIN_COLOR)
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                              Text(
                                title2,
                              ),
                              Wrap(
                                children: [
                                  ...options2.map((singleSize) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          option2 = singleSize;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          border: Border.all(
                                            color: option2 == singleSize
                                                ? Color(MAIN_COLOR)
                                                : Colors.black,
                                          ),
                                        ),
                                        child: Text(
                                          singleSize,
                                          style: TextStyle(
                                            color: option2 == singleSize
                                                ? Color(MAIN_COLOR)
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'العدد المطلوب',
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          count += 1;
                                        });
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.plus,
                                        color: Color(MAIN_COLOR),
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '$count',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (count <= 1) {
                                          return;
                                        }
                                        setState(() {
                                          count -= 1;
                                        });
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.minus,
                                        color: Color(MAIN_COLOR),
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              title: addedToCart
                                  ? 'تم الإضافة بنجاح'
                                  : 'أضيفي واكملي تسوق',
                              onTap: addedToCart
                                  ? null
                                  : userProvider.isLoggedIn
                                      ? () async {
                                          await userProvider.addToCart(
                                            itemId: product.id,
                                            count: count,
                                            price: count * product.price,
                                            option1: option1,
                                            option2: option2,
                                          );
                                          setState(() {
                                            addedToCart = true;
                                          });
                                        }
                                      : () {
                                          Get.defaultDialog(
                                            title: "خطأ",
                                            middleText: 'قم بتسجيل الدخول اولا',
                                            confirm: TextButton(
                                              onPressed: () => Get.back(),
                                              child: Text(
                                                'حسنا',
                                              ),
                                            ),
                                          );
                                        },
                              widthFactor: 0.8,
                            ),
                            // CustomButton(
                            //   title: 'أضيفي وأذهبي للسلة',
                            //   widthFactor: 0.4,
                            //   onTap: userProvider.isLoggedIn
                            //       ? () async {
                            //           await userProvider.addToCart(
                            //             itemId: product.id,
                            //             count: count,
                            //             price: count * product.price,
                            //             color: option1,
                            //             size: option2,
                            //           );
                            //           Get.offNamed(CartTab.id);
                            //         }
                            //       : () {
                            //           Get.defaultDialog(
                            //             title: "خطأ",
                            //             middleText: 'قم بتسجيل الدخول اولا',
                            //             confirm: TextButton(
                            //               onPressed: () => Get.back(),
                            //               child: Text(
                            //                 'حسنا',
                            //               ),
                            //             ),
                            //           );
                            //         },
                            // ),
                          ],
                        ),
                      ],
                    );
                  },
                  itemCount: 1,
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
