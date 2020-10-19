import 'package:flutter/material.dart';
import 'package:mosa_bin/screens/splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

// ScreenUtil.init(context, designSize: Size(360, 640), allowFontScaling: false);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        print(focus.hasPrimaryFocus.toString());
        if (!focus.hasPrimaryFocus && focus.focusedChild != null)
          focus.focusedChild.unfocus();
      },
      child: MaterialApp(
        title: 'MY MOSA',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
