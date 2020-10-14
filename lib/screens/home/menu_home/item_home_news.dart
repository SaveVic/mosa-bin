import 'package:flutter/material.dart';

class ItemHomeNews extends StatelessWidget {
  final String path;
  final double height;
  final double width;
  final double padding;
  final String title;
  final Color titleColor;

  const ItemHomeNews(
      {Key key,
      @required this.path,
      this.height = 100,
      this.title = '',
      this.width = 200,
      this.titleColor = Colors.black,
      this.padding = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(path),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
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
