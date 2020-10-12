import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final double width;
  final double height;
  final bool obsecure;
  final bool error;
  final TextEditingController controller;
  final TextInputType type;
  final String placeholder;
  final IconData suffixIcon;
  final Function onSuffixTap;

  const CustomTextField({
    Key key,
    this.width,
    this.height = 50,
    this.controller,
    this.placeholder,
    this.type = TextInputType.text,
    this.obsecure = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.error = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border:
            Border.all(color: Colors.red, width: (widget.error) ? 1.0 : 0.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 2.0),
            blurRadius: 2.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              obscureText: widget.obsecure,
              controller: widget.controller,
              keyboardType: widget.type,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
              decoration: InputDecoration.collapsed(
                hintText: widget.placeholder,
                hintStyle: TextStyle(
                  color: Color(0xFFC4C4C4),
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          (widget.suffixIcon != null)
              ? GestureDetector(
                  onTap: widget.onSuffixTap,
                  child: Container(
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Color(0xFFA9A9A9),
                    alignment: Alignment.center,
                    child: Icon(
                      widget.suffixIcon,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
