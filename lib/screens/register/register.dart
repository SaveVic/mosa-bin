import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/screens/home/home.dart';
import 'package:mosa_bin/screens/login/login.dart';
import 'package:mosa_bin/screens/register/date_parser.dart';
import 'package:mosa_bin/services/service_register.dart';
import 'package:page_transition/page_transition.dart';

import '../login/style_login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  TextEditingController _controllerRePass = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();

  bool _errorUser = false;
  bool _errorPass = false;
  bool _errorRePass = false;
  bool _errorEmail = false;
  bool _errorDate = false;

  void _toLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: LoginPage(),
      ),
    );
  }

  void _onShowDatePicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      theme: DatePickerTheme(
        itemStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      onConfirm: (date) {
        final _newValue = DateParser.date2display(date);
        _controllerDate.value = TextEditingValue(
          text: _newValue,
        );
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) focus.unfocus();
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void _onRegister(BuildContext ctx) async {
    var serv = ServiceRegister(
      () {
        Navigator.pushReplacement(
          ctx,
          PageTransition(
            type: PageTransitionType.fade,
            child: HomePage(),
          ),
        );
      },
    );
    RegisterValidatorData validator = serv.validator(
      _controllerUser.text,
      _controllerPass.text,
      _controllerRePass.text,
      _controllerEmail.text,
      _controllerDate.text,
    );
    setState(() {
      _errorUser = validator.validUsername;
      _errorPass = validator.validPassword;
      _errorRePass = validator.validRePassword;
      _errorEmail = validator.validEmail;
      _errorDate = validator.validBirthDate;
    });
    if (validator.result)
      serv.registerWithDatabase(
        _controllerUser.text,
        _controllerPass.text,
        _controllerRePass.text,
        _controllerEmail.text,
        _controllerDate.text,
      );
    else
      Fluttertoast.showToast(msg: validator.message);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);
    const double tfMargin = 30;
    const double tfHeight = 40;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 360.w,
          height: 640.h,
          padding: EdgeInsets.symmetric(horizontal: 55.w),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 70.h, bottom: 35.h),
                child: Image.asset(
                  logoPath,
                  width: logoWidth.w,
                  height: logoHeight.h,
                ),
              ),
              CustomTextField(
                width: double.infinity,
                height: tfHeight.h,
                controller: _controllerUser,
                placeholder: 'Username',
                error: _errorUser,
              ),
              SizedBox(height: tfMargin.h),
              CustomTextField(
                width: double.infinity,
                height: tfHeight.h,
                controller: _controllerPass,
                placeholder: 'Password',
                obsecure: true,
                error: _errorPass,
              ),
              SizedBox(height: tfMargin.h),
              CustomTextField(
                width: double.infinity,
                height: tfHeight.h,
                controller: _controllerRePass,
                placeholder: 'Re-Password',
                obsecure: true,
                error: _errorRePass,
              ),
              SizedBox(height: tfMargin.h),
              CustomTextField(
                width: double.infinity,
                height: tfHeight.h,
                controller: _controllerEmail,
                placeholder: 'Email',
                error: _errorEmail,
              ),
              SizedBox(height: tfMargin.h),
              CustomTextField(
                width: double.infinity,
                height: tfHeight.h,
                controller: _controllerDate,
                placeholder: 'Birth Date',
                suffixIcon: Icons.date_range,
                onSuffixTap: () {
                  _onShowDatePicker(context);
                },
                suffixContainerColor: Color(0xFFA9A9A9),
                suffixColor: Colors.white,
                error: _errorDate,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: tfMargin.h),
                child: CustomButton(
                  width: double.infinity,
                  height: buttonHeight.h,
                  color: buttonColor,
                  text: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: buttonTextSize.sp,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _onRegister(context);
                  },
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Sudah memiliki akun ?',
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Login Sekarang',
                        style: TextStyle(
                          color: Color(0xFF6EA8B0),
                          fontSize: 12.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _toLogin(context);
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
