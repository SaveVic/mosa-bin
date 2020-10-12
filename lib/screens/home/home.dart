import 'package:flutter/material.dart';
import 'package:mosa_bin/screens/home/menu_home/menu_home.dart';
import 'package:mosa_bin/screens/home/style_home.dart';

class HomePage extends StatelessWidget {
  final List<Map> listsNavItem = [
    {
      'icon': Icons.home,
      'label': 'Home',
    },
    {
      'icon': Icons.help,
      'label': 'Help',
    },
    {
      'icon': Icons.person,
      'label': 'Akun',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MenuHome(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: StyleHome.baseColor,
        items: List<BottomNavigationBarItem>.generate(
          listsNavItem.length,
          (i) => BottomNavigationBarItem(
            icon: Icon(
              listsNavItem[i]['icon'],
              color: Colors.white,
            ),
            label: listsNavItem[i]['label'],
          ),
        ),
      ),
    );
  }
}
