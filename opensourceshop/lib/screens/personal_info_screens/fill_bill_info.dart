import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:opensourceshop/providers/user_provider.dart';
import 'package:opensourceshop/screens/bill_screen/bill_screen.dart';
import 'package:opensourceshop/screens/widgets/custom_button.dart';
import 'package:opensourceshop/screens/widgets/text_input_widget.dart';
import 'package:provider/provider.dart';

import '../../constatnts.dart';

class FillBillInfo extends StatefulWidget {
  static String id = '/fillBillInfoScreenff';
  @override
  _FillBillInfoState createState() => _FillBillInfoState();
}

class _FillBillInfoState extends State<FillBillInfo> {
  bool isInit = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  String groupValue = 'الضفة (20)';

  @override
  void didChangeDependencies() {
    if (isInit) {
      var userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      userName = TextEditingController(text: userProvider.deliveryName);
      phone = TextEditingController(text: userProvider.deliveryPhone);
      address = TextEditingController(text: userProvider.deliveryAddress);

      groupValue = userProvider.user.deliveryAddress;
      isInit = false;
    }
    super.didChangeDependencies();
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
              'تأكيد بيانات المستخدم',
            ),
            backgroundColor: Color(MAIN_COLOR),
          ),
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: Container(
              child: Column(
                children: [
                  // MainAppBar(),
                  // Divider(),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(15),
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
                        Column(
                          children: [
                            CustomButton(
                              title: 'اصدار فاتورة',
                              onTap: () {
                                userProvider.updateDeliveryData(
                                  delivertyName: userName.text,
                                  deliveryAddress: address.text,
                                  deliveryPhone: phone.text,
                                );
                                // userProvider.updateDeliveryPrice(groupValue);
                                Get.toNamed(
                                  BillScreen.id,
                                  arguments: {
                                    'myBillsScreen': false,
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Divider(),
                  // MainBottomBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
