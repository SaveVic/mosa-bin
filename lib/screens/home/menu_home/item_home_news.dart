import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemHomeNews extends StatelessWidget {
  final String path;
  final double height;
  final double padding;
  final String title;
  final Color titleColor;

  const ItemHomeNews(
      {Key key,
      @required this.path,
      this.height = 100,
      this.title = '',
      this.titleColor = Colors.black,
      this.padding = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context,
    //     designSize: Size(360, 640), allowFontScaling: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              path,
              height: height,
            ),
            // child: Container(
            //   height: height,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(path),
            //     ),
            //   ),
            // ),
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: titleColor,
            ),
          ),
        ],
      ),
    );
  }
}
