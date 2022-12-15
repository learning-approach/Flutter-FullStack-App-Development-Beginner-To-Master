import 'package:chatapp/const/app_colors.dart';
import 'package:chatapp/business_logic/auth.dart';
import 'package:chatapp/ui/route/route.dart';
import 'package:chatapp/ui/widgets/customButton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/customTextField.dart';

class SignIn extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 80.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login\nTo Your Account",
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.caribbeanGreen,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              customTextField(
                _emailController,
                TextInputType.emailAddress,
                "email",
                prefixIcon: Icons.email_outlined,
              ),
              customTextField(
                _passwordController,
                TextInputType.text,
                "password",
                obscureText: true,
                prefixIcon: Icons.remove_red_eye_outlined,
              ),
              SizedBox(
                height: 40.h,
              ),
              authButton(
                "Login",
                () => Auth().login(
                    _emailController.text, _passwordController.text, context),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "--OR--",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              RichText(
                text: TextSpan(
                  text: "Don’t have registered yet?  ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.caribbeanGreen,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(signUp),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
