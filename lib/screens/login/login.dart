import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/models/shared_pref.dart';
import 'package:mosa_bin/models/user.dart';
import 'package:mosa_bin/screens/home/home.dart';
import 'package:mosa_bin/screens/login/data_login.dart';
import 'package:mosa_bin/screens/register/register.dart';
import 'package:page_transition/page_transition.dart';

import 'style_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

  SharedPreferencesHelper helper = SharedPreferencesHelper();

  bool _errorUser = false;
  bool _errorPass = false;

  bool _validate() {
    if (_controllerUser.text.isNotEmpty && _controllerPass.text.isNotEmpty)
      return true;
    return false;
  }

  _onLogin(BuildContext ctx) async {
    if (_validate()) {
      if (_controllerUser.text == username &&
          _controllerPass.text == password) {
        await helper.setData(User('admin', 'admin', true));
        Navigator.pushReplacement(
          ctx,
          PageTransition(
            type: PageTransitionType.fade,
            child: HomePage(),
          ),
        );
      } else
        Fluttertoast.showToast(msg: 'Username atau Password salah');
    } else {
      Fluttertoast.showToast(msg: 'Username dan Password tidak boleh kosong');
      setState(() {
        _errorUser = _controllerUser.text.isEmpty;
        _errorPass = _controllerPass.text.isEmpty;
      });
    }
  }

  void _toRegister(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);

    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          width: 360.w,
          height: 640.h,
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 200.h,
                  bottom: 80.h,
                ),
                child: Image.asset(
                  logoPath,
                  width: logoWidth.w,
                  height: logoHeight.h,
                ),
              ),
              CustomTextField(
                width: double.infinity,
                controller: _controllerUser,
                placeholder: 'Username atau Email',
                error: _errorUser,
              ),
              SizedBox(height: 15.0.h),
              CustomTextField(
                width: double.infinity,
                controller: _controllerPass,
                placeholder: 'Password',
                obsecure: true,
                error: _errorPass,
              ),
              SizedBox(height: 15.0.h),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Text(
                  'Lupa Password',
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    color: Color(0xFF6EA8B0),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 25.h),
                alignment: Alignment.center,
                child: CustomButton(
                  width: buttonWidth.w,
                  height: buttonHeight.h,
                  color: buttonColor,
                  text: Text(
                    'LOG IN',
                    style: TextStyle(
                      fontSize: buttonTextSize.sp,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _onLogin(context);
                  },
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Belum memiliki akun ?',
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Daftar Sekarang',
                        style: TextStyle(
                          color: Color(0xFF6EA8B0),
                          fontSize: 12.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _toRegister(context);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
