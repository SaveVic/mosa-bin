import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:mosa_bin/models/intro.dart';
import 'package:mosa_bin/models/shared_pref.dart';
import 'package:mosa_bin/models/user.dart';
import 'package:mosa_bin/screens/intro/style_intro.dart';
import 'package:mosa_bin/screens/login/pre_login.dart';
import 'package:page_transition/page_transition.dart';

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
      User(null, null, true),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new IntroSlider(
      slides: List<Slide>.generate(
        introList.length,
        (i) => Slide(
          backgroundColor: Colors.white,
          widgetTitle: Image.asset(
            StyleIntro.titlePath,
            width: width * StyleIntro.titleWidthFactor,
            height: height * StyleIntro.titleHeightFactor,
          ),
          pathImage: introList[i].image,
          widthImage: width * StyleIntro.imageWidthFactor,
          heightImage: height * StyleIntro.imageHeightFactor,
          description: introList[i].description,
          styleDescription: TextStyle(
            color: StyleIntro.descColor,
            fontSize: StyleIntro.descSize,
          ),
        ),
      ),
      onDonePress: () async {
        await onDonePress();
      },
      colorDot: StyleIntro.dotColor,
      colorActiveDot: StyleIntro.dotActivateColor,
      styleNameSkipBtn: TextStyle(
        color: StyleIntro.dotColor,
        fontSize: StyleIntro.descSize,
      ),
      styleNamePrevBtn: TextStyle(
        color: StyleIntro.dotColor,
        fontSize: StyleIntro.descSize,
      ),
      styleNameDoneBtn: TextStyle(
        color: StyleIntro.dotColor,
        fontSize: StyleIntro.descSize,
      ),
    );
  }
}
