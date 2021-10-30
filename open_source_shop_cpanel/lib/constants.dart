const MAIN_COLOR = 0xffa1888e;

// heroku https://open-source-app-control-panel.herokuapp.com/
// http://localhost:3600
const BASE_URL = 'https://open-source-app-control-panel.herokuapp.com';
const CREATE_CATEGORY = BASE_URL + '/api/v1/category';
const GET_ALL_CATEGORIES = BASE_URL + '/api/v1/category';

// sub categories
const GET_SUB_CATEGORIES = BASE_URL + '/api/v1/subCategory';
const CREATE_SUB_CATEGORY = BASE_URL + '/api/v1/subCategory';

// products
const GET_ALL_PRODUCTS = BASE_URL + '/api/v1/products';
const CREATE_PRODUCT = BASE_URL + '/api/v1/products';
const UPDATE_PRODUCT = BASE_URL + '/api/v1/products/';

// orders
const GET_ORDERS = BASE_URL + '/api/v1/admin/orders';
const UPDATE_ORDER_STATE = BASE_URL + '/api/v1/admin/updateOrderState';

// messages
const GET_ALL_USERS_MESSAGES = BASE_URL + '/api/v1/messages';
