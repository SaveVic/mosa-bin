import 'package:flutter/material.dart';
import 'package:mosa_bin/components/bottom_navbar.dart';
import 'package:mosa_bin/screens/home/menu_akun/menu_akun.dart';
import 'package:mosa_bin/screens/home/menu_help/menu_help.dart';
import 'package:mosa_bin/screens/home/menu_home/menu_home.dart';

class HomePage extends StatefulWidget {
  final int initIndex;

  const HomePage({Key key, this.initIndex = 0}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex;

  @override
  initState() {
    super.initState();
    _currentIndex = widget.initIndex;
  }

  void _changeState(int id) {
    if (id < 0) return;
    setState(() {
      _currentIndex = id;
    });
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return MenuHome(onSetState: _changeState);
        break;
      case 1:
        return MenuHelp();
        break;
      case 2:
        return MenuAkun();
        break;
      default:
        return MenuHome(onSetState: _changeState);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_currentIndex != 0)
          ? AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xFF6A9923),
              leading: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: Text(
                (_currentIndex == 1) ? 'Help' : 'Akun',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : null,
      body: _getBody(),
      resizeToAvoidBottomInset: false,
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
