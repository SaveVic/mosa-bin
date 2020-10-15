import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemTestimoni extends StatelessWidget {
  final String user;
  final String msg;

  const ItemTestimoni({Key key, this.user, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context,
    //     designSize: Size(360, 640), allowFontScaling: false);
    return Container(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.person_outline, size: 40.w, color: Colors.black),
          SizedBox(width: 20.w),
          Expanded(
            child: Text(
              '$user\n$msg',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
