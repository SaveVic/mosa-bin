import 'package:flutter/material.dart';
import 'package:mosa_bin/screens/home/style_home.dart';

class MainBottomNavBar extends StatelessWidget {
  final int pos;
  final Function(int) onSelected;

  MainBottomNavBar({Key key, @required this.pos, @required this.onSelected})
      : super(key: key);

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
    return BottomNavigationBar(
      currentIndex: pos,
      onTap: (id) {
        onSelected(id);
      },
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
    );
  }
}
