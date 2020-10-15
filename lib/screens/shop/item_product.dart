import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemProduct extends StatelessWidget {
  final Map prod;

  const ItemProduct({Key key, @required this.prod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 2),
            spreadRadius: 2.0,
            blurRadius: 2.0,
          ),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(prod['img']),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            prod['name'],
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            prod['owner'],
            style: TextStyle(
              fontSize: 9.sp,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${prod['price']} / ${prod['unit']}',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.black,
                ),
              ),
              Text(
                '${prod['rating']}',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${prod['point']} poin',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.black,
                ),
              ),
              Text(
                '${prod['sold']} terjual',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
