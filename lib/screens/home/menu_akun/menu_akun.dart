import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/components/custom_loading.dart';
import 'package:mosa_bin/models/db_user.dart';
// import 'package:mosa_bin/models/record_user.dart';
// import 'package:mosa_bin/models/shared_pref.dart';
// import 'package:mosa_bin/models/user.dart';
import 'package:mosa_bin/screens/home/menu_akun/data_akun.dart';
import 'package:mosa_bin/screens/login/pre_login.dart';
import 'package:mosa_bin/services/service_account.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';

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
  final ImagePicker picker = ImagePicker();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _controllerName = TextEditingController();

  String nickname = '??';
  double totalWeight = -1;
  int countBottle = -1;
  int cash = -1;
  UserDB user;
  File _file;

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

  Future<void> selectImage(ImageSource source) async {
    PickedFile image =
        await ImagePicker().getImage(source: source, imageQuality: 70);
    if (image != null && image.path != null) {
      final String path = (await getApplicationDocumentsDirectory()).path;
      print('$path/${user.username}${user.id}.png');
      final File newFile =
          await File(image.path).copy('$path/${user.username}${user.id}.png');
      print(newFile.path);
      await serv.changeAva(user, newFile.path);
      setState(() {
        _file = newFile;
      });
      // Fluttertoast.showToast(msg: 'Ganti foto ${(t) ? 'berhasil' : 'gagal'}');
    }
  }

  Future<void> _onAvaEdit(BuildContext ctx) async {
    showModalBottomSheet(
      context: ctx,
      builder: (bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Ambil dari Gallery'),
                  onTap: () async {
                    await selectImage(ImageSource.gallery);
                    Navigator.of(ctx).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Ambil dari Kamera'),
                  onTap: () async {
                    await selectImage(ImageSource.camera);
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    // File image = await ImagePicker().getImage(source: ImageSour)
  }

  Future<void> _onLogout(BuildContext context) async {
    bool t = await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Log out'),
            content: Text('Apakah anda yakin ingin log out?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Kembali'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Log out'),
              ),
            ],
          ),
        ) ??
        false;
    if (t) {
      Dialogs.showLoadingDialog(context, _keyLoader);
      await serv.logoutDatabase();
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        PageTransition(child: PreLoginPage(), type: PageTransitionType.fade),
      );
    }
  }

  Future<File> _initFileAva() async {
    if (user == null) return null;
    if (user.fotoPath == null) return null;
    bool t = await File(user.fotoPath).exists();
    if (!t) return null;
    return File(user.fotoPath);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDB>(
      future: serv.getAccountInfoDatabase(),
      builder: (_, snap) {
        nickname = (snap.hasData) ? snap.data.nickname : '??';
        totalWeight = (snap.hasData) ? snap.data.totalWeight : -1;
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
                    child: Icon(Icons.edit, size: 15.h, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              buildInformation(
                path: icon_litter,
                descTitle: 'Total berat sampah yang di kumpulkan',
                descSub:
                    '${(totalWeight >= 0) ? totalWeight : '??'} kg Sampah Organik',
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

  Widget buildAva() {
    return FutureBuilder<File>(
      future: _initFileAva(),
      builder: (ctx, snap) {
        _file = (snap.hasData) ? snap.data : null;
        if (_file == null)
          return Container(
            width: 2 * ava_radius.h,
            height: 2 * ava_radius.h,
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              color: Colors.grey,
            ),
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: Icon(Icons.person, color: Colors.black),
            ),
          );
        else
          return CircleAvatar(
            radius: ava_radius.h,
            backgroundImage: FileImage(_file),
          );
      },
    );
  }

  Widget buildProfilePict() {
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
          child: buildAva(),
        ),
        Positioned(
          left: widget.width / 2 +
              sqrt(cam_size.h * (2 * ava_radius - cam_size).h),
          top: bg_ratio * bg_height.h - cam_size.h,
          child: GestureDetector(
            onTap: () {
              if (user == null) return;
              _onAvaEdit(context);
            },
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
