import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:mosa_bin/models/intro.dart';
import 'package:mosa_bin/models/shared_pref.dart';
import 'package:mosa_bin/models/user.dart';
import 'package:mosa_bin/screens/login/pre_login.dart';
import 'package:page_transition/page_transition.dart';

import 'style_intro.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List<Intro> introList = [
    Intro(
      image: 'assets/images/intro/intro1.png',
      description: 'Membantu kamu dalam mewujudkan Indonesia bebas sampah',
    ),
    Intro(
      image: 'assets/images/intro/intro2.png',
      description:
          'Membantu kamu dalam mengumpulkan sampah organik dan non-organik secara digital',
    ),
    Intro(
      image: 'assets/images/intro/intro3.png',
      description: 'Memudahkan Kamu dalam membeli produk-produk organik',
    ),
  ];

  Future onDonePress() async {
    SharedPreferencesHelper helper = SharedPreferencesHelper();
    await helper.setData(
      UserData(null, null, true),
    );
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: PreLoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);

    return new IntroSlider(
      slides: List<Slide>.generate(
        introList.length,
        (i) => Slide(
          backgroundColor: Colors.white,
          widgetTitle: Image.asset(
            titlePath,
            width: titleWidth.w,
            height: titleHeight.h,
          ),
          pathImage: introList[i].image,
          widthImage: imageWidth.w,
          // heightImage: imageHeight.h,
          description: introList[i].description,
          styleDescription: TextStyle(
            color: descColor,
            fontSize: descSize.sp,
          ),
        ),
      ),
      onDonePress: () async {
        await onDonePress();
      },
      colorDot: dotColor,
      colorActiveDot: dotActivateColor,
      styleNameSkipBtn: TextStyle(
        color: dotColor,
        fontSize: descSize.sp,
      ),
      styleNamePrevBtn: TextStyle(
        color: dotColor,
        fontSize: descSize.sp,
      ),
      styleNameDoneBtn: TextStyle(
        color: dotColor,
        fontSize: descSize.sp,
      ),
    );
  }
}
