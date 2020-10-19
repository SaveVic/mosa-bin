import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemHomeMain extends StatelessWidget {
  final String path;
  final Color color;
  final String descText;
  final Color descColor;
  final Function onPressed;

  const ItemHomeMain(
      {Key key,
      @required this.path,
      this.color = Colors.blue,
      this.descText = '',
      this.descColor = Colors.black,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 50.h,
              height: 50.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: color,
              ),
              child: FractionallySizedBox(
                widthFactor: 0.6,
                heightFactor: 0.6,
                child: Image.asset(path),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            descText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: descColor,
            ),
          )
        ],
      ),
    );
  }
}
