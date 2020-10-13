import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  final bool obsecure;
  final bool error;
  final bool shadow;
  final TextEditingController controller;
  final TextInputType type;
  final String placeholder;
  final IconData suffixIcon;
  final Color suffixContainerColor;
  final Color suffixColor;
  final Color fieldColor;
  final Function onSuffixTap;

  const CustomTextField({
    Key key,
    @required this.width,
    this.height = 50,
    @required this.controller,
    @required this.placeholder,
    this.type = TextInputType.text,
    this.obsecure = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.error = false,
    this.radius = 5,
    this.shadow = true,
    this.suffixContainerColor = Colors.white,
    this.suffixColor = Colors.black,
    this.fieldColor = Colors.white,
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
        borderRadius: BorderRadius.circular(widget.radius),
        border:
            Border.all(color: Colors.red, width: (widget.error) ? 1.0 : 0.0),
        color: widget.fieldColor,
        boxShadow: [
          (widget.shadow)
              ? BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 2.0),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                )
              : BoxShadow(),
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
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    color: widget.suffixContainerColor,
                    alignment: Alignment.center,
                    child: Icon(
                      widget.suffixIcon,
                      size: 26,
                      color: widget.suffixColor,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
