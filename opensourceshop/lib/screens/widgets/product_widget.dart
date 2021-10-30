import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constatnts.dart';

class ProductWidget extends StatefulWidget {
  final onTap, image, title, price, id;
  ProductWidget({
    this.onTap,
    this.image,
    this.title,
    this.price,
    this.id,
  });

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: SHADOW,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(5),
        // width: Get.width * 0.4,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 2,
                        ),
                        Text(
                          'السعر ${widget.price}' + ' ' + PRICE_SYMBOL,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: FaIcon(
                      isFav
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      color: Color(MAIN_COLOR),
                      size: 30,
                    ),
                    onTap: userProvider.isLoggedIn
                        ? () async {
                            var userProvider = Provider.of<UserProvider>(
                              context,
                              listen: false,
                            );
                            if (isFav) {
                              await userProvider
                                  .removeFromFavourites(widget.id);
                            } else {
                              await userProvider.addToFavourites(widget.id);
                            }
                            setState(() {
                              isFav = !isFav;
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
                  ),
                ],
              ),
            ),

            // HeartButton(
            //   onTap: userProvider.isLoggedIn
            //       ? () async {
            //           var userProvider = Provider.of<UserProvider>(
            //             context,
            //             listen: false,
            //           );
            //           if (isFav) {
            //             await userProvider.removeFromFavourites(widget.id);
            //           } else {
            //             await userProvider.addToFavourites(widget.id);
            //           }
            //           setState(() {
            //             isFav = !isFav;
            //           });
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
            //   icon: isFav ? FontAwesomeIcons.minus : FontAwesomeIcons.plus,
            // ),
          ],
        ),
      ),
    );
  }
}


// Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(5),
//                 margin: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Color(MAIN_COLOR),
//                   borderRadius: BorderRadius.circular(
//                     15,
//                   ),
//                 ),
//                 child: Text(
//                   'إضافة لمشترياتي',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: Get.width * 0.035,
//                   ),
//                 ),
//               ),