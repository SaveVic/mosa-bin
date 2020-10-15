import 'package:flutter/material.dart';
import 'package:mosa_bin/screens/splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

// ScreenUtil.init(context, designSize: Size(360, 640), allowFontScaling: false);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My MOSA',
      home: SplashScreen(),
    );
  }
}
