import 'package:flutter/material.dart';
import 'package:mosa_bin/screens/home/style_home.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: StyleHome.baseColor,
        items: [],
      ),
    );
  }
}
