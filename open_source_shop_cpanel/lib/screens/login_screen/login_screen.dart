import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nada_control_panel/constants.dart';
import 'package:nada_control_panel/screens/main_categories_screens/main_categories_screen.dart';
import 'package:nada_control_panel/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController(),
      passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final storage = GetStorage();
      if (storage.read('loggedIn') == true) {
        Get.offAllNamed(MainCategoriesScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'images/logo.png',
                  ),
                  CustomTextField(
                    hint: 'User Name',
                    fontColor: Colors.black,
                    borderColor: Colors.black,
                    validator: (userName) {
                      if (userName.isEmpty) {
                        return "Please Enter User Name";
                      } else {
                        return null;
                      }
                    },
                    controller: userNameController,
                  ),
                  CustomTextField(
                    hint: 'Password',
                    fontColor: Colors.black,
                    borderColor: Colors.black,
                    validator: (password) {
                      if (password.isEmpty) {
                        return "Please Enter Password";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                  ),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState.validate()) {
                        if (userNameController.text == 'openapp' &&
                            passwordController.text == 'openapp') {
                          final storage = GetStorage();
                          storage.write('loggedIn', true);
                          Get.offAllNamed(MainCategoriesScreen.id);
                        } else {
                          Get.snackbar('Error', "Wrong User Name Or Password");
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(MAIN_COLOR),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      width: Get.width * 0.7,
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
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
}
