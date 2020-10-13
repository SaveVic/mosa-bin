import 'package:flutter/material.dart';
import 'package:mosa_bin/components/bottom_navbar.dart';
import 'package:mosa_bin/screens/home/menu_akun/menu_akun.dart';
import 'package:mosa_bin/screens/home/menu_help/menu_help.dart';
import 'package:mosa_bin/screens/home/menu_home/menu_home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return MenuHome();
        break;
      case 1:
        return MenuHelp();
        break;
      case 2:
        return MenuAkun();
        break;
      default:
        return MenuHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: MainBottomNavBar(
        pos: _currentIndex,
        onSelected: (id) {
          setState(() {
            _currentIndex = id;
          });
        },
      ),
    );
  }
}
