import 'package:flutter/material.dart';

import '../../constatnts.dart';

class TextInputWidget extends StatelessWidget {
  final title, icon, onChange, validator, initialValue, controller;

  TextInputWidget({
    this.title,
    this.icon,
    this.onChange,
    this.validator,
    this.initialValue,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
