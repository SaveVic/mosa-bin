import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final Text text;
  final Function onPressed;

  const CustomButton(
      {Key key, this.color, this.width, this.height, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
        alignment: Alignment.center,
        width: width,
        height: height,
        child: text,
      ),
    );
  }
}
