import 'package:flutter/material.dart';

class ItemHomeMain extends StatelessWidget {
  final String path;
  final double size;
  final Color color;
  final String descText;
  final Color descColor;
  final Function onPressed;

  const ItemHomeMain(
      {Key key,
      @required this.path,
      this.size = 50,
      this.color = Colors.blue,
      this.descText = '',
      this.descColor = Colors.black,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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