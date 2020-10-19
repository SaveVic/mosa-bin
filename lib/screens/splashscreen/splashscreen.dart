import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosa_bin/models/shared_pref.dart';
import 'package:mosa_bin/models/user.dart';
import 'package:mosa_bin/screens/home/home.dart';
import 'package:mosa_bin/screens/intro/intro_page.dart';
import 'package:mosa_bin/screens/login/pre_login.dart';
import 'package:page_transition/page_transition.dart';
import 'style_splash.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferencesHelper helper;

  @override
  void initState() {
    super.initState();
    helper = SharedPreferencesHelper();
    _checkToken();
  }

  _checkToken() async {
    await Future.delayed(Duration(milliseconds: 1000));
    UserData data = await helper.getData();

    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: (data.username == null && !data.done_intro)
            ? IntroPage()
            : (data.username == null && data.done_intro)
                ? PreLoginPage()
                : HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          logoPath,
          width: logoWidth.w,
          height: logoHeight.h,
        ),
      ),
    );
  }
}
