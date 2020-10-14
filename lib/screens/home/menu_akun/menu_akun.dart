import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/screens/home/menu_akun/data_akun.dart';
import 'package:mosa_bin/screens/login/pre_login.dart';
import 'package:page_transition/page_transition.dart';

class MenuAkun extends StatelessWidget {
  final double width;
  final double bg_height = 100;
  final double ava_radius = 80;
  final double cam_size = 30;

  const MenuAkun({Key key, this.width}) : super(key: key);

  void _onLogout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageTransition(child: PreLoginPage(), type: PageTransitionType.fade),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          buildProfilePict(),
          SizedBox(height: 10),
          Text(
            nickname,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 40),
          buildInformation(
            path: icon_litter,
            descTitle: 'Total berat sampah yang di kumpulkan',
            descSub: '$total_weight kg Sampah Organik',
            color: Color(0xFFADDB31),
          ),
          buildInformation(
            path: icon_litter,
            descTitle: 'Total sampah botol yang dikumpulkan',
            descSub: '$total_bottle Botol',
            color: Color(0xFF97E18B),
          ),
          buildInformation(
            path: icon_money,
            descTitle: 'Total Poin',
            descSub: '$total_point poin',
            color: Color(0xFFF9B915),
          ),
          buildInformation(
            path: icon_cart,
            descTitle: 'Informasi Pembelian',
            color: Color(0xFF6A9923),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(right: 20),
            child: CustomButton(
              color: Color(0xFF59981A),
              width: 120,
              height: 40,
              text: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _onLogout(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInformation(
      {String path, String descTitle, String descSub = '', Color color}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      color: color,
      child: Row(
        children: [
          Image.asset(
            path,
            width: 40,
            height: 40,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                descTitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              (descSub.isNotEmpty)
                  ? Text(
                      descSub,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Stack buildProfilePict() {
    return Stack(
      children: [
        Container(height: 2 * bg_height),
        Container(
          height: bg_height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg_path),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 2 * (bg_height - ava_radius),
          left: width / 2 - ava_radius,
          child: CircleAvatar(
            radius: ava_radius,
            backgroundImage: AssetImage(pict_path),
          ),
        ),
        Positioned(
          left: width / 2 + sqrt(cam_size * (2 * ava_radius - cam_size)),
          top: 2 * bg_height - cam_size,
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.camera_alt,
              size: cam_size,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
