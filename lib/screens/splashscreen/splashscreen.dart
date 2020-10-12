import 'package:flutter/material.dart';
import 'package:mosa_bin/models/shared_pref.dart';
import 'package:mosa_bin/models/user.dart';
import 'package:mosa_bin/screens/intro/intro_page.dart';
import 'package:mosa_bin/screens/login/login.dart';
import 'package:mosa_bin/screens/login/pre_login.dart';
import 'package:mosa_bin/screens/splashscreen/style_splash.dart';
import 'package:page_transition/page_transition.dart';

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

  @override
  void dispose() {
    super.dispose();
  }

  _checkToken() async {
    await Future.delayed(Duration(milliseconds: 3000));
    User data = await helper.getData();
    // Widget target;
    // if (data.auth_token == null && !data.done_intro)
    //   target = IntroPage();
    // else if (data.done_intro)
    //   target = PreLoginPage();
    // else
    //   target = LoginPage();

    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: (data.auth_token == null && !data.done_intro)
            ? IntroPage()
            : (data.auth_token == null && data.done_intro)
                ? PreLoginPage()
                : LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          StyleSplash.logoPath,
          width: MediaQuery.of(context).size.width * StyleSplash.widthFactor,
          height: MediaQuery.of(context).size.height * StyleSplash.heightFactor,
        ),
      ),
    );
  }
}
