import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/screens/home/menu_akun/data_akun.dart';
import 'package:mosa_bin/screens/login/pre_login.dart';
import 'package:page_transition/page_transition.dart';

class MenuAkun extends StatelessWidget {
  final double width;
  final double bg_height = 80;
  final double ava_radius = 50;
  final double cam_size = 17;

  const MenuAkun({Key key, this.width}) : super(key: key);

  void _onLogout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageTransition(child: PreLoginPage(), type: PageTransitionType.fade),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          buildProfilePict(),
          SizedBox(height: 6.h),
          Text(
            nickname,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 25.h),
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
            margin: EdgeInsets.only(right: 20.w),
            child: CustomButton(
              color: Color(0xFF59981A),
              width: 120.w,
              height: 40.h,
              text: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16.sp,
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
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      color: color,
      child: Row(
        children: [
          Image.asset(
            path,
            width: 40.w,
            height: 40.h,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                descTitle,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              (descSub.isNotEmpty)
                  ? Text(
                      descSub,
                      style: TextStyle(
                        fontSize: 16.sp,
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
        Container(height: (2 * bg_height).h),
        Container(
          height: bg_height.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg_path),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 2 * (bg_height - ava_radius).h,
          left: width.w / 2 - ava_radius.h,
          child: CircleAvatar(
            radius: ava_radius.h,
            backgroundImage: AssetImage(pict_path),
          ),
        ),
        Positioned(
          left: width.w / 2 + sqrt(cam_size.h * (2 * ava_radius - cam_size).h),
          top: 2 * bg_height.h - cam_size.h,
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
