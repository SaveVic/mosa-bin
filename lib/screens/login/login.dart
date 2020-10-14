import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/screens/home/home.dart';
import 'package:mosa_bin/screens/login/style_login.dart';
import 'package:mosa_bin/screens/register/register.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

  bool _errorUser = false;
  bool _errorPass = false;

  bool _validate() {
    if (_controllerUser.text.isNotEmpty && _controllerPass.text.isNotEmpty)
      return true;
    return false;
  }

  void _onLogin(BuildContext context) {
    if (_validate()) {
      //login
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                placeholder: 'Username atau Email',
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
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Text(
                  'Lupa Password',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF6EA8B0),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 25),
                alignment: Alignment.center,
                child: CustomButton(
                  width: width * StyleLogin.buttonWidthFactor,
                  height: height * StyleLogin.buttonHeightFactor,
                  color: StyleLogin.buttonColor,
                  text: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: StyleLogin.buttonTextSize,
                      color: StyleLogin.buttonTextColor,
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
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Daftar Sekarang',
                        style: TextStyle(
                          color: Color(0xFF6EA8B0),
                          fontSize: 12,
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
