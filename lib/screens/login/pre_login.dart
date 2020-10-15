import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/screens/login/login.dart';
import 'package:mosa_bin/screens/register/register.dart';
import 'package:page_transition/page_transition.dart';
import 'style_login.dart';

class PreLoginPage extends StatelessWidget {
  void _toLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: LoginPage(),
      ),
    );
  }

  void _toRegister(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);

    return Scaffold(
      body: Container(
        width: 360.w,
        height: 640.h,
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Image.asset(
                logoPath,
                width: logoWidth.w,
                height: logoHeight.h,
              ),
            ),
            SizedBox(height: logoMargin.h),
            Text(
              'Welcome to MOSA!',
              style: TextStyle(
                fontSize: titleSize.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: descMargin.h),
            Text(
              'Are you ready to enjoy a whole new live without waste ? Let’s go !',
              style: TextStyle(
                fontSize: descSize.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: descMargin.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  width: buttonWidth.w,
                  height: buttonHeight.h,
                  color: buttonColor,
                  text: Text(
                    'LOG IN',
                    style: TextStyle(
                      fontSize: buttonTextSize.sp,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _toLogin(context);
                  },
                ),
                CustomButton(
                  width: buttonWidth.w,
                  height: buttonHeight.h,
                  color: buttonColor,
                  text: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: buttonTextSize.sp,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _toRegister(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
