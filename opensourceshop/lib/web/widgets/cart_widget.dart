import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/models/cart_item_model.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/single_product_screen/single_product_screen.dart';
import 'package:provider/provider.dart';
import '../../constatnts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartWidget extends StatefulWidget {
  final CartItem item;
  final onRemovePressed;

  CartWidget({
    this.item,
    this.onRemovePressed,
  });

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return InkWell(
      onTap: () => Get.toNamed(
        SingleProductScreen.id,
        arguments: {
          'product': widget.item.product,
        },
      ),
      child: Container(
        width: 150.w,
        height: Get.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: SHADOW,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: SHADOW,
                image: DecorationImage(
                  image: NetworkImage(
                    widget.item.product.image,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              height: Get.height * 0.1,
              width: Get.height * 0.1,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.product.name.toString(),
                  ),
                  Text(
                    widget.item.option1.toString(),
                  ),
                  Text(
                    widget.item.option2.toString(),
                  ),
                  Text(
                    '${widget.item.price.toString()}' + '  ' + PRICE_SYMBOL,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Color(MAIN_COLOR),
                    size: 30,
                  ),
                  onPressed: widget.onRemovePressed,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        setState(() {
                          widget.item.count += 1;
                          widget.item.price += widget.item.product.price;
                        });
                        userProvider.addToTotalPrice(widget.item.product.price);
                        await userProvider.updateItemCount(
                          widget.item.id,
                          widget.item.count,
                          widget.item.price,
                        );
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
                      widget.item.count.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        if (widget.item.count <= 1) {
                          return;
                        }
                        setState(() {
                          widget.item.count -= 1;
                          widget.item.price -= widget.item.product.price;
                        });
                        userProvider
                            .subFromTotalPrice(widget.item.product.price);
                        await userProvider.updateItemCount(
                          widget.item.id,
                          widget.item.count,
                          widget.item.price,
                        );
                      },
                      child: Icon(
                        FontAwesomeIcons.minus,
                        color: Color(MAIN_COLOR),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
