import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/web/widgets/not_logged_in_widget.dart';
import 'package:provider/provider.dart';
import 'package:opensourceshop/web/widgets/text_input_widget.dart';
import 'package:opensourceshop/constatnts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatefulWidget {
  static String id = '/profileTabScreen';

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool isInit = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  String groupValue = 'الضفة (20)';
  // bool showButton = Get.arguments['showCustomButton'] ?? false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      var userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      userName = TextEditingController(text: userProvider.user.name);
      email = TextEditingController(text: userProvider.user.email);
      password = TextEditingController(text: userProvider.user.password);
      phone = TextEditingController(text: userProvider.user.phone);
      address = TextEditingController(text: userProvider.user.address);
      groupValue = userProvider.user.deliveryAddress;
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: provider.isLoggedIn
              ? Form(
                  key: formKey,
                  child: Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Container(
                      width: 200.w,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        // padding: const EdgeInsets.all(15),
                        children: [
                          TextInputWidget(
                            title: 'الإسم',
                            controller: userName,
                            icon: FontAwesomeIcons.userAlt,
                          ),
                          TextInputWidget(
                            title: 'رقم الهاتف',
                            controller: phone,
                            icon: FontAwesomeIcons.phoneAlt,
                          ),
                          TextInputWidget(
                            title: 'العنوان',
                            controller: address,
                            icon: FontAwesomeIcons.mapMarkerAlt,
                          ),
                          // Row(
                          //   children: [
                          //     Radio(
                          //       value: 'الضفة (20)',
                          //       onChanged: (value) {
                          //         setState(() {
                          //           groupValue = value;
                          //         });
                          //       },
                          //       groupValue: groupValue,
                          //     ),
                          //     Text(
                          //       'الضفة (20)',
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Radio(
                          //       value: 'القدس (30)',
                          //       onChanged: (value) {
                          //         setState(() {
                          //           groupValue = value;
                          //         });
                          //       },
                          //       groupValue: groupValue,
                          //     ),
                          //     Text(
                          //       'القدس (30)',
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Radio(
                          //       value: 'الداخل (80)',
                          //       onChanged: (value) {
                          //         setState(() {
                          //           groupValue = value;
                          //         });
                          //       },
                          //       groupValue: groupValue,
                          //     ),
                          //     Text(
                          //       'الداخل (80)',
                          //     ),
                          //   ],
                          // ),
                          // if (showButton == false)
                          TextInputWidget(
                            title: 'البريد الإلكتروني',
                            controller: email,
                            icon: FontAwesomeIcons.envelope,
                          ),
                          // if (showButton == false)
                          TextInputWidget(
                            title: 'كلمة المرور',
                            controller: password,
                            icon: FontAwesomeIcons.key,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(MAIN_COLOR)),
                                elevation: MaterialStateProperty.all(5),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                minimumSize: MaterialStateProperty.all(
                                  Size(
                                    Get.width * 0.7,
                                    Get.height * 0.05,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  Get.dialog(
                                    Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                  try {
                                    final userProvider =
                                        Provider.of<UserProvider>(
                                      context,
                                      listen: false,
                                    );
                                    Dio dio = Dio();
                                    final response = await dio.patch(
                                      EDIT_USER_DATA,
                                      data: {
                                        "userName": userName.text,
                                        "email": email.text,
                                        "password": password.text,
                                        "address": address.text,
                                        "phone": phone.text,
                                        "jwt": userProvider.user.jwt,
                                      },
                                    );
                                    if (response.statusCode == 200) {
                                      await userProvider.updateUserData(
                                          response.data, password.text);
                                      Get.back();
                                      Get.back();
                                    } else {
                                      Get.defaultDialog(
                                        title: 'Error',
                                        middleText:
                                            'Wrong User Name Or Password Please Try Again Later',
                                        confirm: TextButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.back();
                                          },
                                          child: Text(
                                            "OK",
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print(e);
                                    Get.defaultDialog(
                                      title: 'Error',
                                      middleText:
                                          'Wrong User Name Or Password Please Try Again Later',
                                      confirm: TextButton(
                                        onPressed: () {
                                          Get.back();
                                          Get.back();
                                        },
                                        child: Text(
                                          "OK",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'حفظ التعديلات',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // if (showButton == true)
                          // Column(
                          //   children: [
                          //     // Container(
                          //     //   margin: const EdgeInsets.symmetric(
                          //     //     vertical: 15,
                          //     //   ),
                          //     //   child: Row(
                          //     //     mainAxisAlignment:
                          //     //         MainAxisAlignment.spaceBetween,
                          //     //     children: [
                          //     //       Text(
                          //     //         'سعر الشراء',
                          //     //         style: TextStyle(
                          //     //           color: Color(0XFF646464),
                          //     //           fontSize: Get.width * 0.04,
                          //     //         ),
                          //     //       ),
                          //     //       Text(
                          //     //         '\$55',
                          //     //         style: TextStyle(
                          //     //           fontSize: Get.width * 0.04,
                          //     //           fontWeight: FontWeight.bold,
                          //     //         ),
                          //     //       ),
                          //     //     ],
                          //     //   ),
                          //     // ),
                          //     // Container(
                          //     //   margin: const EdgeInsets.symmetric(
                          //     //     vertical: 15,
                          //     //   ),
                          //     //   child: Row(
                          //     //     mainAxisAlignment:
                          //     //         MainAxisAlignment.spaceBetween,
                          //     //     children: [
                          //     //       Text(
                          //     //         'التوصيل',
                          //     //         style: TextStyle(
                          //     //           color: Color(0XFF646464),
                          //     //           fontSize: Get.width * 0.04,
                          //     //         ),
                          //     //       ),
                          //     //       Text(
                          //     //         '\$3.50',
                          //     //         style: TextStyle(
                          //     //           fontSize: Get.width * 0.04,
                          //     //           fontWeight: FontWeight.bold,
                          //     //         ),
                          //     //       ),
                          //     //     ],
                          //     //   ),
                          //     // ),
                          //     // Container(
                          //     //   margin: const EdgeInsets.symmetric(
                          //     //     vertical: 15,
                          //     //   ),
                          //     //   child: Divider(
                          //     //     thickness: 2,
                          //     //   ),
                          //     // ),
                          //     // Container(
                          //     //   margin: const EdgeInsets.symmetric(
                          //     //     vertical: 15,
                          //     //   ),
                          //     //   child: Row(
                          //     //     mainAxisAlignment:
                          //     //         MainAxisAlignment.spaceBetween,
                          //     //     children: [
                          //     //       Text(
                          //     //         'الإجمالي',
                          //     //         style: TextStyle(
                          //     //           color: Color(0XFF646464),
                          //     //           fontSize: Get.width * 0.05,
                          //     //         ),
                          //     //       ),
                          //     //       Text(
                          //     //         '\$55',
                          //     //         style: TextStyle(
                          //     //           fontSize: Get.width * 0.05,
                          //     //           fontWeight: FontWeight.bold,
                          //     //         ),
                          //     //       ),
                          //     //     ],
                          //     //   ),
                          //     // ),
                          //     // CustomButton(
                          //     //   title: 'اصدار فاتورة',
                          //     //   onTap: () => Get.toNamed(
                          //     //     BillScreen.id,
                          //     //     arguments: {
                          //     //       'myBillsScreen': false,
                          //     //     },
                          //     //   ),
                          //     // ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                )
              : NotLoggedInWidgetWeb(
                  title: 'انت غير مشترك سجل الدخول او اشترك حتى تستطيع الإكمال',
                ),
        ),
      ),
    );
  }
}
