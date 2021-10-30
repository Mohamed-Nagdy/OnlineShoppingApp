import 'package:flutter/material.dart';

const MAIN_COLOR = 0xffa1888e;
const PRICE_SYMBOL = 'ج م';

const SHADOW = [
  BoxShadow(
    color: Colors.grey,
    blurRadius: 2,
    offset: Offset(0.0, 2.0),
  ),
];

// all links we need

// heroku https://open-source-app-control-panel.herokuapp.com/
const BASE_URL = "https://open-source-app-control-panel.herokuapp.com";

// categories links
const GET_CATEGORIES = BASE_URL + "/api/v1/category";
const GET_PRODUCTS_WITH_CATEGORY_ID = BASE_URL + '/api/v1/products/category/';

// cart links
const ADD_ITEM_TO_CART = BASE_URL + '/api/v1/addCart';
const GET_USER_CART = BASE_URL + '/api/v1/getCart';
const REMOVE_ITEM_FROM_CART = BASE_URL + '/api/v1/removeCartItem';
const UPDATE_ITEM_COUNT = BASE_URL + '/api/v1/updateCount';

// orders links
const SUBMIT_ORDER = BASE_URL + '/api/v1/submitOrder';
const GET_USER_ORDERS = BASE_URL + '/api/v1/getOrders';
const GET_SINGLE_ORDER = BASE_URL + '/api/v1/getSingleOrder';

// user links
const LOGIN = BASE_URL + '/api/v1/users/login';
const SIGN_UP = BASE_URL + '/api/v1/users/signup';
const EDIT_USER_DATA = BASE_URL + '/api/v1/users/editUser';
const USER_MESSAGES = BASE_URL + '/api/v1/messages/';

// fav links
const FAV_LINK = BASE_URL + '/api/v1/users/getFav';
const ADD_TO_FAV = BASE_URL + '/api/v1/users/addFav';
const REMOVE_FROM_FAV = BASE_URL + '/api/v1/users/removeFav';
