import 'package:flutter/material.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/screens/login/login.dart';
import 'package:mosa_bin/screens/login/style_login.dart';
import 'package:mosa_bin/screens/register/register.dart';
import 'package:page_transition/page_transition.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 33),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(bottom: StyleLogin.logoMargin),
              child: Image.asset(
                StyleLogin.logoPath,
                width: width * StyleLogin.logoWidthFactor,
                height: height * StyleLogin.logoHeightFactor,
              ),
            ),
            Text(
              StyleLogin.titleText,
              style: TextStyle(
                fontSize: StyleLogin.titleSize,
                color: StyleLogin.titleColor,
                fontWeight: StyleLogin.titleWeight,
              ),
            ),
            SizedBox(height: StyleLogin.descMargin),
            Text(
              StyleLogin.descText,
              style: TextStyle(
                fontSize: StyleLogin.descSize,
                color: StyleLogin.descColor,
              ),
            ),
            SizedBox(height: StyleLogin.descMargin),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  width: width * StyleLogin.buttonWidthFactor,
                  height: height * StyleLogin.buttonHeightFactor,
                  color: StyleLogin.buttonColor,
                  text: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: StyleLogin.buttonTextSize,
                      color: StyleLogin.buttonTextColor,
                    ),
                  ),
                  onPressed: () {
                    _toLogin(context);
                  },
                ),
                CustomButton(
                  width: width * StyleLogin.buttonWidthFactor,
                  height: height * StyleLogin.buttonHeightFactor,
                  color: StyleLogin.buttonColor,
                  text: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: StyleLogin.buttonTextSize,
                      color: StyleLogin.buttonTextColor,
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
