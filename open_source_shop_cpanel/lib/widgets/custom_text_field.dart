import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final hint,
      borderColor,
      fontColor,
      controller,
      validator,
      onFieldSubmitted,
      isSecure,
      keyBoardType;

  CustomTextField({
    this.hint,
    this.controller,
    this.borderColor,
    this.fontColor,
    this.validator,
    this.onFieldSubmitted,
    this.isSecure = false,
    this.keyBoardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.cairo(
        color: fontColor,
      ),
      keyboardType: keyBoardType,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: isSecure,
      decoration: InputDecoration(
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: borderColor)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
