import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/web/widgets/custom_button.dart';
import 'package:opensourceshop/web/widgets/text_input_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import '../../constatnts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginAndSignUpScreenWeb extends StatefulWidget {
  static String id = '/loginAndSignupScreenWeb';
  @override
  _LoginAndSignUpScreenWebState createState() =>
      _LoginAndSignUpScreenWebState();
}

class _LoginAndSignUpScreenWebState extends State<LoginAndSignUpScreenWeb> {
  Widget shownWidget;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  String groupValue = 'الضفة (20)';
  bool showSignup = false;

  @override
  void initState() {
    shownWidget = loginPart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'التسجيل وإنشاء حساب',
            ),
            backgroundColor: Color(MAIN_COLOR),
          ),
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        title: 'تسجيل دخول',
                        widthFactor: 0.4,
                        onTap: () {
                          setState(() {
                            showSignup = false;
                          });
                        },
                      ),
                      CustomButton(
                        title: 'مستخدم جديد',
                        widthFactor: 0.4,
                        onTap: () {
                          setState(() {
                            showSignup = true;
                          });
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: showSignup
                        ? SingleChildScrollView(
                            child: Container(
                              child: Column(
                                children: [
                                  TextInputWidget(
                                    title: 'الإسم',
                                    icon: FontAwesomeIcons.userAlt,
                                    controller: userName,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Please Enter User Name";
                                      } else if (value.length < 6) {
                                        return "user name must 6 characters length";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  TextInputWidget(
                                    title: 'رقم الهاتف',
                                    icon: FontAwesomeIcons.phoneAlt,
                                    controller: phone,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Please Enter Phone";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  TextInputWidget(
                                    title: 'العنوان',
                                    icon: FontAwesomeIcons.mapMarkerAlt,
                                    controller: address,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Please Enter Address";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  TextInputWidget(
                                    title: 'البريد الإلكتروني',
                                    icon: FontAwesomeIcons.envelope,
                                    controller: email,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Please Enter Email Address";
                                      } else if (!EmailValidator.validate(
                                          value)) {
                                        return 'email not valid please check extra spaces';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  TextInputWidget(
                                    title: 'كلمة المرور',
                                    icon: FontAwesomeIcons.key,
                                    controller: password,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Please Enter Password";
                                      } else if (value.length < 8) {
                                        return "Password Must 8 Charcters Length";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  // Container(
                                  //   margin: const EdgeInsets.all(15),
                                  //   alignment: Alignment.centerRight,
                                  //   child: Text(
                                  //     'المنطقة',
                                  //     textAlign: TextAlign.right,
                                  //   ),
                                  // ),
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

                                  Container(
                                    width: 200.w,
                                    child: CustomButton(
                                      title: 'إنشاء حساب',
                                      onTap: () async {
                                        if (formKey.currentState.validate()) {
                                          Get.dialog(
                                            Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                          try {
                                            bool isLogged = await userProvider
                                                .loginAndSignUpAndEdit(
                                              {
                                                "userName": userName.text,
                                                "email": email.text,
                                                "password": password.text,
                                                "address": address.text,
                                                "phone": phone.text,
                                                // "deliverAddress": groupValue,
                                              },
                                              SIGN_UP,
                                            );
                                            if (isLogged) {
                                              final storage = GetStorage();
                                              storage.write(
                                                'email',
                                                email.text,
                                              );
                                              storage.write(
                                                'password',
                                                password.text,
                                              );
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
                                                  'Error Happened Please Try Again Later',
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Container(
                              height: Get.height * 0.6,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextInputWidget(
                                    title: 'البريد الإلكتروني',
                                    controller: email,
                                    icon: FontAwesomeIcons.envelope,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Please Enter Email Address";
                                      } else if (!EmailValidator.validate(
                                          value)) {
                                        return 'email not valid please check extra spaces';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  TextInputWidget(
                                    title: 'كلمة المرور',
                                    controller: password,
                                    icon: FontAwesomeIcons.key,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Please Enter Password";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  Container(
                                    width: 200.w,
                                    child: CustomButton(
                                      title: 'دخول',
                                      onTap: () async {
                                        if (formKey.currentState.validate()) {
                                          Get.dialog(
                                            Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                          try {
                                            bool isLogged = await userProvider
                                                .loginAndSignUpAndEdit(
                                              {
                                                "email": email.text,
                                                "password": password.text,
                                              },
                                              LOGIN,
                                            );
                                            if (isLogged) {
                                              final storage = GetStorage();
                                              storage.write(
                                                'email',
                                                email.text,
                                              );
                                              storage.write(
                                                'password',
                                                password.text,
                                              );
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginPart() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextInputWidget(
              title: 'Email',
            ),
            TextInputWidget(
              title: 'Password',
            ),
            CustomButton(
              title: 'دخول',
            ),
          ],
        ),
      ),
    );
  }

  Widget signupPart() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            TextInputWidget(
              title: 'الإسم',
              icon: FontAwesomeIcons.userAlt,
            ),
            TextInputWidget(
              title: 'رقم الهاتف',
              icon: FontAwesomeIcons.phoneAlt,
            ),
            TextInputWidget(
              title: 'العنوان',
              icon: FontAwesomeIcons.mapMarkerAlt,
            ),
            Row(
              children: [
                Radio(
                  value: '20',
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                  groupValue: groupValue,
                ),
                Text(
                  'الضفة (20)',
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: '30',
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                  groupValue: groupValue,
                ),
                Text(
                  'القدس (30)',
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: '80',
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                  groupValue: groupValue,
                ),
                Text(
                  'الداخل (80)',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
