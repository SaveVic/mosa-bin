import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/models/db_user.dart';
// import 'package:mosa_bin/models/record_user.dart';
// import 'package:mosa_bin/models/shared_pref.dart';
// import 'package:mosa_bin/models/user.dart';
import 'package:mosa_bin/screens/home/menu_akun/data_akun.dart';
import 'package:mosa_bin/screens/login/pre_login.dart';
import 'package:mosa_bin/services/service_account.dart';
import 'package:page_transition/page_transition.dart';

class MenuAkun extends StatefulWidget {
  final double width;

  MenuAkun({Key key, this.width}) : super(key: key);

  @override
  _MenuAkunState createState() => _MenuAkunState();
}

class _MenuAkunState extends State<MenuAkun> {
  final double bg_height = 80;
  final double bg_ratio = 1.5;
  final double ava_radius = 50;
  final double cam_size = 17;
  final ServiceAccount serv = ServiceAccount();
  TextEditingController _controllerName = TextEditingController();
  String nickname = '??';
  double trashWeight = -1;
  int countBottle = -1;
  int cash = -1;
  UserDB user;

  // Future<UserRecord> _getUserData(BuildContext context) async {
  //   User cur = auth.currentUser;
  //   if (cur == null) {
  //     return null;
  //   }
  //   DocumentSnapshot data = await ref.collection('users').doc(cur.uid).get();
  //   UserRecord user = UserRecord.fromSnapshot(data);
  //   return user;
  // }

  Future<bool> _onEditNickname(BuildContext context) async {
    bool t = await showDialog(
          context: context,
          barrierDismissible: false,
          child: AlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: TextField(
                            controller: _controllerName,
                            decoration: InputDecoration(
                              hintText: 'Nickname',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  CustomButton(
                    color: Color(0xFF6A9923),
                    width: 80.w,
                    height: 30.h,
                    text: Text(
                      'Ubah',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () {
                      if (_controllerName.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Nickname tidak boleh kosong');
                        return;
                      }
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
    if (!t) {
      _controllerName.value = TextEditingValue.empty;
    }
    return t;
  }

  Future<void> _onLogout(BuildContext context) async {
    // await auth.signOut();
    serv.logoutDatabase(() {
      Navigator.pushReplacement(
        context,
        PageTransition(child: PreLoginPage(), type: PageTransitionType.fade),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDB>(
      future: serv.getAccountInfoDatabase(),
      builder: (_, snap) {
        nickname = (snap.hasData) ? snap.data.nickname : '??';
        trashWeight = (snap.hasData) ? snap.data.trashWeight : -1;
        countBottle = (snap.hasData) ? snap.data.countBottle : -1;
        cash = (snap.hasData) ? snap.data.cash : -1;
        user = (snap.hasData) ? snap.data : null;
        return Container(
          width: double.infinity,
          child: Column(
            children: [
              buildProfilePict(),
              SizedBox(height: 6.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nickname,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () async {
                      bool res = await _onEditNickname(context);
                      if (res) {
                        await serv.changeNickname(user, _controllerName.text);
                        setState(() {
                          nickname = _controllerName.text;
                        });
                      }
                    },
                    child: Icon(Icons.edit, size: 10.w),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              buildInformation(
                path: icon_litter,
                descTitle: 'Total berat sampah yang di kumpulkan',
                descSub:
                    '${(trashWeight >= 0) ? trashWeight : '??'} kg Sampah Organik',
                color: Color(0xFFADDB31),
              ),
              buildInformation(
                path: icon_litter,
                descTitle: 'Total sampah botol yang dikumpulkan',
                descSub: '${(countBottle >= 0) ? countBottle : '??'} Botol',
                color: Color(0xFF97E18B),
              ),
              buildInformation(
                path: icon_money,
                descTitle: 'Saldo',
                descSub: 'Rp.${(cash >= 0) ? cash : '??'}',
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
                  width: 100.w,
                  height: 30.h,
                  text: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 12.sp,
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
      },
    );
  }

  Widget buildInformation(
      {String path, String descTitle, String descSub = '', Color color}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      color: color,
      child: Row(
        children: [
          Image.asset(
            path,
            width: 30.w,
            height: 30.h,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                descTitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              (descSub.isNotEmpty)
                  ? Text(
                      descSub,
                      style: TextStyle(
                        fontSize: 12.sp,
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
        Container(height: bg_ratio * bg_height.h),
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
          top: bg_ratio * bg_height.h - 2 * ava_radius.h,
          left: widget.width / 2 - ava_radius.h,
          child: CircleAvatar(
            radius: ava_radius.h,
            backgroundImage: AssetImage(pict_path),
          ),
        ),
        Positioned(
          left: widget.width / 2 +
              sqrt(cam_size.h * (2 * ava_radius - cam_size).h),
          top: bg_ratio * bg_height.h - cam_size.h,
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.camera_alt,
              size: cam_size.h,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
