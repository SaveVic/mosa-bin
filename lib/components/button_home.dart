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
          FlatButton(
            onPressed: onPressed,
            child: Image.asset(
              path,
              width: size,
              height: size,
            ),
            // child: new Icon(
            //   Icons.arrow_forward,
            //   color: Colors.white,
            //   size: 20.0,
            // ),
            shape: new CircleBorder(),
            color: color,
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
