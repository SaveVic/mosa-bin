import 'package:flutter/material.dart';

class ButtonHomeItem extends StatelessWidget {
  final String path;
  final double size;
  final Color color;
  final String descText;
  final Color descColor;
  final Function onPressed;

  const ButtonHomeItem(
      {Key key,
      this.path,
      this.size,
      this.color,
      this.descText,
      this.descColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              alignment: Alignment.center,
              width: size,
              height: size,
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: color,
              ),
              child: Image.asset(
                path,
                width: size / 2,
                height: size / 2,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            descText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: descColor,
            ),
          )
        ],
      ),
    );
  }
}
