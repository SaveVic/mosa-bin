import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/screens/home/home.dart';
import 'package:mosa_bin/screens/login/login.dart';
import 'package:mosa_bin/screens/login/style_login.dart';
import 'package:mosa_bin/screens/register/date_parser.dart';
import 'package:page_transition/page_transition.dart';

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

  bool _validate() {
    if (_controllerUser.text.isNotEmpty &&
        _controllerPass.text.isNotEmpty &&
        _controllerRePass.text.isNotEmpty &&
        _controllerPass.text == _controllerRePass.text &&
        _controllerEmail.text.isNotEmpty &&
        DateParser.validateDisplay(_controllerDate.text)) return true;
    return false;
  }

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

  void _onRegister(BuildContext context) {
    if (_validate()) {
      //register
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: HomePage(),
        ),
      );
    } else {
      setState(() {
        _errorUser = _controllerUser.text.isEmpty;
        _errorPass = _controllerPass.text.isEmpty ||
            _controllerPass.text != _controllerRePass.text;
        _errorRePass = _controllerRePass.text.isEmpty ||
            _controllerPass.text != _controllerRePass.text;
        _errorEmail = _controllerEmail.text.isEmpty;
        _errorDate = !DateParser.validateDisplay(_controllerDate.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: 55,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 200,
                  bottom: 80,
                ),
                child: Image.asset(
                  StyleLogin.logoPath,
                  width: width * StyleLogin.logoWidthFactor,
                  height: height * StyleLogin.logoHeightFactor,
                ),
              ),
              CustomTextField(
                width: double.infinity,
                controller: _controllerUser,
                placeholder: 'Username',
                error: _errorUser,
              ),
              SizedBox(height: 15.0),
              CustomTextField(
                width: double.infinity,
                controller: _controllerPass,
                placeholder: 'Password',
                obsecure: true,
                error: _errorPass,
              ),
              SizedBox(height: 15.0),
              CustomTextField(
                width: double.infinity,
                controller: _controllerRePass,
                placeholder: 'Re-Password',
                obsecure: true,
                error: _errorRePass,
              ),
              SizedBox(height: 15.0),
              CustomTextField(
                width: double.infinity,
                controller: _controllerEmail,
                placeholder: 'Email',
                error: _errorEmail,
              ),
              SizedBox(height: 15.0),
              CustomTextField(
                width: double.infinity,
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
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CustomButton(
                  width: double.infinity,
                  height: height * StyleLogin.buttonHeightFactor,
                  color: StyleLogin.buttonColor,
                  text: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: StyleLogin.buttonTextSize,
                      color: StyleLogin.buttonTextColor,
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
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Login Sekarang',
                        style: TextStyle(
                          color: Color(0xFF6EA8B0),
                          fontSize: 12,
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
