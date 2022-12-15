import 'package:chatapp/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget authButton(String title, final Function onAction) {
  return InkWell(
    onTap: () {
      onAction();
    },
    child: Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.caribbeanGreen,
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17.sp,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
