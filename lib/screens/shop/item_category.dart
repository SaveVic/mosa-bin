import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCategory extends StatelessWidget {
  final String path;
  final String label;
  final double image_height = 150;
  final double label_cover_height = 120;
  final double label_size = 12;

  const ItemCategory({Key key, @required this.path, @required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.w),
      ),
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.only(bottom: 10.h),
      child: Container(
        width: double.infinity,
        height: image_height.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(path),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: label_cover_height.h,
          padding: EdgeInsets.symmetric(vertical: 20.h),
          alignment: Alignment.center,
          color: Colors.white.withOpacity(0.73),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: label_size.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
