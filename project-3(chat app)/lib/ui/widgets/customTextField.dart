import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextField(
  controller,
  keyboardType,
  hint, {
  prefixIcon,
  obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 15.sp,
      ),
      prefixIcon: Icon(prefixIcon,size: 16,),
    ),
    
  );
}
