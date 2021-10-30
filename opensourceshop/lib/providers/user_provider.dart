import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:opensourceshop/models/cart_item_model.dart';
import 'package:opensourceshop/models/category_model.dart';
import 'package:opensourceshop/models/order_model.dart';
import 'package:opensourceshop/models/product_model.dart';
import 'package:opensourceshop/models/single_order_model.dart';
import 'package:opensourceshop/models/user_model.dart';
import 'package:get/get.dart';

class UserProvider extends ChangeNotifier {
  User user = User();
  bool isLoggedIn = false;
  Dio dio = Dio();
  double totalPrice = 0.0;
  int itemsCount = 0;

  double deliveryPrice = 0.0;
  String deliveryAddress = '';
  String deliveryName = '';
  String deliveryPhone = '';

  // all data holders
  List<Category> categories = [];
  List<Product> products = [];
  List<Product> favourites = [];

  void updateDeliveryPrice(var address) {
    switch (address) {
      case 'الضفة (20)':
        deliveryPrice = 20;
        break;
      case 'القدس (30)':
        deliveryPrice = 30;
        break;
      case 'الداخل (80)':
        deliveryPrice = 80;
        break;
    }
    notifyListeners();
  }

  void updateDeliveryData({
    deliveryPrice,
    deliveryAddress,
    delivertyName,
    deliveryPhone,
  }) {
    this.deliveryPrice = deliveryPrice;
    this.deliveryPhone = deliveryPhone;
    this.deliveryName = deliveryName;
    this.deliveryAddress = deliveryAddress;
    notifyListeners();
  }

  Future<bool> loginAndSignUpAndEdit(var data, String url) async {
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        user = User.fromJson(response.data);
        user.password = data['password'];
        updateDeliveryPrice(user.deliveryAddress);
        deliveryAddress = user.address;
        deliveryName = user.name;
        deliveryPhone = user.phone;
        isLoggedIn = true;
        notifyListeners();
        return Future.value(true);
      }
    } catch (e) {
      print(e);
      return Future.value(false);
    }
    return Future.value(false);
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }

  Future<void> updateUserData(var jsonData, var password) {
    this.user = User.fromJson(jsonData);
    this.user.password = password;
    notifyListeners();
    return Future.value();
  }

////////////////////////////////////////////////////////////////////////
  ///                                                                 ////
  ///                     Favourites Providers                        ////
  ///                                                                 ////
////////////////////////////////////////////////////////////////////////

  Future<List<Product>> getFavourites() async {
    try {
      final response = await dio.post(
        FAV_LINK,
        data: {
          'jwt': user.jwt,
        },
      );
      favourites.clear();

      response.data.forEach((fav) {
        favourites.add(Product.fromJson(fav));
      });
    } catch (e) {
      print(e);
    }
    return Future.value(favourites);
  }

  Future<void> removeFromFavourites(var productId) async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await dio.post(
        REMOVE_FROM_FAV,
        data: {
          'jwt': user.jwt,
          'id': productId,
        },
      );
      Get.back();
    } catch (e) {
      Get.back();
      print(e);
    }
    return Future.value();
  }

  Future<void> addToFavourites(var productId) async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await dio.post(
        ADD_TO_FAV,
        data: {
          'jwt': user.jwt,
          'id': productId,
        },
      );
      Get.back();
    } catch (e) {
      Get.back();
      print(e);
    }
    return Future.value();
  }

////////////////////////////////////////////////////////////////////////
  ///                                                                 ////
  ///                     Cart Providers                              ////
  ///                                                                 ////
////////////////////////////////////////////////////////////////////////

  Future<List<CartItem>> getUserCart() async {
    totalPrice = 0;
    itemsCount = 0;
    List<CartItem> items = [];
    try {
      final response = await dio.post(
        GET_USER_CART,
        data: {
          'jwt': user.jwt,
        },
      );
      response.data.forEach((item) {
        items.add(CartItem.fromJson(item));
      });
      items.forEach((element) {
        totalPrice += element.price;
        itemsCount += element.count;
      });
    } catch (e) {
      print(e);
    }
    return Future.value(items);
  }

  // add item to the cart
  Future<void> addToCart({
    itemId,
    count,
    price,
    option1,
    option2,
  }) async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await dio.post(
        ADD_ITEM_TO_CART,
        data: {
          'jwt': user.jwt,
          'item': {
            'product': itemId,
            'count': count,
            'price': price,
            'option1': option1,
            'option2': option2,
          },
        },
      );
      Get.back();
    } catch (e) {
      Get.back();
      print(e);
    }
    return Future.value();
  }

  // remove item from cart
  Future<void> removeFromCart(var itemId) async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await dio.post(
        REMOVE_ITEM_FROM_CART,
        data: {
          'jwt': user.jwt,
          'id': itemId,
        },
      );
      Get.back();
    } catch (e) {
      Get.back();
      print(e);
    }
    return Future.value();
  }

  Future<void> updateItemCount(
    var itemId,
    var itemCount,
    var itemPrice,
  ) async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await dio.post(
        UPDATE_ITEM_COUNT,
        data: {
          'jwt': user.jwt,
          'id': itemId,
          'count': itemCount,
          'price': itemPrice,
        },
      );
      Get.back();
    } catch (e) {
      Get.back();
      print(e);
    }
    return Future.value();
  }

  void addToTotalPrice(var price) {
    totalPrice += price;
    itemsCount += 1;
    notifyListeners();
  }

  void subFromTotalPrice(var price) {
    totalPrice -= price;
    itemsCount -= 1;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////
  ///                                                                 ////
  ///                     Orders Providers                            ////
  ///                                                                 ////
////////////////////////////////////////////////////////////////////////

  Future<void> submitOrder() async {
    try {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
      );
      await dio.post(
        SUBMIT_ORDER,
        data: {
          'jwt': user.jwt,
          'phone': this.deliveryPhone,
          'name': this.deliveryName,
          'address': this.deliveryAddress,
          'deliverPrice': this.deliveryPrice,
        },
      );
      Get.back();
    } catch (e) {
      Get.back();
      print(e);
    }
    return Future.value();
  }

  Future<List<Order>> getUserOrders() async {
    List<Order> orders = [];
    try {
      final response = await dio.post(
        GET_USER_ORDERS,
        data: {
          'jwt': user.jwt,
        },
      );
      response.data.forEach((item) {
        orders.add(Order.fromJson(item));
      });
    } catch (e) {
      print(e);
    }
    return Future.value(orders);
  }

  Future<SingleOrder> getSingleOrder(var id) async {
    SingleOrder order;
    try {
      final response = await dio.post(
        GET_SINGLE_ORDER,
        data: {
          'jwt': user.jwt,
          'id': id,
        },
      );
      print(response.data);
      order = SingleOrder.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return Future.value(order);
  }

////////////////////////////////////////////////////////////////////////
  ///                                                                 ////
  ///                     Categories Providers                        ////
  ///                                                                 ////
////////////////////////////////////////////////////////////////////////

  Future<List<Category>> getCategories() async {
    try {
      final response = await dio.get(GET_CATEGORIES);
      categories.clear();
      response.data
          .forEach((category) => {categories.add(Category.fromJson(category))});
    } catch (e) {
      print(e);
    }
    return Future.value(categories);
  }

  ////////////////////////////////////////////////////////////////////////
  ///                                                                 ////
  ///                     Products Providers                          ////
  ///                                                                 ////
////////////////////////////////////////////////////////////////////////

  Future<List<Product>> getAllProducts(catId) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(GET_PRODUCTS_WITH_CATEGORY_ID + catId);
      products.clear();
      response.data.forEach((product) {
        products.add(Product.fromJson(product));
      });
    } catch (e) {
      print(e);
    }
    return products;
  }
}
