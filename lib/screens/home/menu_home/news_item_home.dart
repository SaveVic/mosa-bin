import 'package:flutter/material.dart';

class ItemNewsHome extends StatelessWidget {
  final String path;
  final double height;
  final double width;
  final String title;
  final Color titleColor;

  const ItemNewsHome(
      {Key key,
      this.path,
      this.height,
      this.title,
      this.width,
      this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              path,
              height: height,
              width: width,
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: titleColor,
            ),
          ),
        ],
      ),
    );
  }
}
