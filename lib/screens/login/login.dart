import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/components/custom_loading.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/screens/home/home.dart';
import 'package:mosa_bin/screens/register/register.dart';
import 'package:mosa_bin/services/service_login.dart';
import 'package:page_transition/page_transition.dart';

import 'style_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  bool _errorUser = false;
  bool _errorPass = false;

  Future<void> _onLogin(BuildContext ctx) async {
    var serv = ServiceLogin();
    LoginValidatorData validator = serv.validator(
      _controllerUser.text,
      _controllerPass.text,
    );
    setState(() {
      _errorUser = !validator.validUsername;
      _errorPass = !validator.validPassword;
    });
    if (validator.result) {
      Dialogs.showLoadingDialog(context, _keyLoader);
      bool t = await serv.loginWithDatabase(
          _controllerUser.text, _controllerPass.text);
      Navigator.of(context).pop();
      if (t)
        Navigator.pushReplacement(
          ctx,
          PageTransition(
            type: PageTransitionType.fade,
            child: HomePage(),
          ),
        );
    } else
      Fluttertoast.showToast(msg: validator.message);
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
