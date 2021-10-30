import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constatnts.dart';

class TextInputWidget extends StatelessWidget {
  final title, icon, onChange, validator, initialValue, controller, hint;

  TextInputWidget({
    this.title,
    this.icon,
    this.onChange,
    this.validator,
    this.initialValue,
    this.controller,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      margin: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
            child: Text(
              title,
            ),
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(MAIN_COLOR),
                  )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(MAIN_COLOR),
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(MAIN_COLOR),
                  )),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(MAIN_COLOR),
                  )),
              contentPadding: const EdgeInsets.all(5),
              prefixIcon: Icon(
                icon,
                size: 20,
                color: Colors.grey[400],
              ),
            ),
            onChanged: onChange,
            validator: validator,
            initialValue: initialValue,
          ),
        ],
      ),
    );
  }
}
