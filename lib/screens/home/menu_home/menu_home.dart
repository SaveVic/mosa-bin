import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mosa_bin/screens/home/menu_home/item_home_main.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/screens/home/menu_home/item_home_news.dart';
import 'package:mosa_bin/screens/pick_up/pick_up.dart';
import 'package:mosa_bin/screens/shop/shop_browse.dart';
import 'package:mosa_bin/screens/trash_bin/trash_bin.dart';
import 'package:page_transition/page_transition.dart';

import '../style_home.dart';

import 'data_home.dart';

class MenuHome extends StatelessWidget {
  final Function(int) onSetState;
  final TextEditingController _controllerSearch = TextEditingController();

  MenuHome({Key key, @required this.onSetState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context,
    //     designSize: Size(360, 640), allowFontScaling: false);
    double width = 360.w;
    double height = 640.h;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTopBar(height),
        buildHomeUpperItem(context, height),
        buildHomeLowerItem(context, height),
        buildNewsFeed(80.h),
      ],
    );
  }

  void _navigateMain(BuildContext ctx, String page) async {
    if (page == 'article') return;
    int res = await Navigator.push(
          ctx,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: (page == 'jemput')
                ? PickUpPage()
                : (page == 'trash')
                    ? TrashBinPage()
                    : (page == 'shop')
                        ? ShopBrowsePage() // Article Page
                        : null,
          ),
        ) ??
        0;
    onSetState(res);
  }

  Widget buildNewsFeed(double newsHeight) {
    return Container(
      color: newsColor,
      padding: EdgeInsets.symmetric(vertical: 15),
      width: 360.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              'Berita Terbaru',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            // height: height,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(
                  itemsNews.length,
                  (i) => ItemHomeNews(
                    path: itemsNews[i]['path'] ?? '',
                    height: newsHeight,
                    padding: 10.w,
                    title: itemsNews[i]['title'] ?? '',
                    titleColor: Color(0xFF595454),
                  ),
                ),
              ),
            ),
            // child: ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: itemsNews.length,
            //   itemBuilder: (ctx, i) {
            //     return ItemHomeNews(
            //       path: itemsNews[i]['path'] ?? '',
            //       height: 80.h,
            //       padding: 10.w,
            //       title: itemsNews[i]['title'] ?? '',
            //       titleColor: Color(0xFF595454),
            //     );
            //   },
            // ),
          )
        ],
      ),
    );
  }

  Widget buildHomeUpperItem(BuildContext context, double height) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180.w,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 20.h),
              child: ItemHomeMain(
                path: itemsMenu[0]['path'] ?? '',
                descText: itemsMenu[0]['label'] ?? '',
                descColor: Color(0xFF595454),
                color: baseColor,
                onPressed: () {
                  _navigateMain(context, itemsMenu[0]['nav'] ?? '');
                },
              ),
            ),
            Container(
              width: 180.w,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 20.h),
              child: ItemHomeMain(
                path: itemsMenu[1]['path'] ?? '',
                descText: itemsMenu[1]['label'] ?? '',
                descColor: Color(0xFF595454),
                color: baseColor,
                onPressed: () {
                  _navigateMain(context, itemsMenu[1]['nav'] ?? '');
                },
              ),
            ),
          ],
        ),
      ),
      // child: GridView.count(
      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //   shrinkWrap: true,
      //   crossAxisCount: 2,
      //   mainAxisSpacing: 20.w,
      //   crossAxisSpacing: 20.h,
      //   children: List<Widget>.generate(
      //     itemsMenu.length,
      //     (i) => ItemHomeMain(
      //       path: itemsMenu[i]['path'] ?? '',
      //       descText: itemsMenu[i]['label'] ?? '',
      //       descColor: Color(0xFF595454),
      //       color: baseColor,
      //       onPressed: () {
      //         _navigateMain(context, itemsMenu[i]['nav'] ?? '');
      //       },
      //     ),
      //   ),
      // ),
    );
  }

  Widget buildHomeLowerItem(BuildContext context, double height) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180.w,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 20.h),
              child: ItemHomeMain(
                path: itemsMenu[2]['path'] ?? '',
                descText: itemsMenu[2]['label'] ?? '',
                descColor: Color(0xFF595454),
                color: baseColor,
                onPressed: () {
                  _navigateMain(context, itemsMenu[2]['nav'] ?? '');
                },
              ),
            ),
            Container(
              width: 180.w,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 20.h),
              child: ItemHomeMain(
                path: itemsMenu[3]['path'] ?? '',
                descText: itemsMenu[3]['label'] ?? '',
                descColor: Color(0xFF595454),
                color: baseColor,
                onPressed: () {
                  _navigateMain(context, itemsMenu[3]['nav'] ?? '');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTopBar(double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(15.w, 30.h, 15.w, 15.h),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0.w)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            logoPath,
            height: logoHeight.h,
          ),
          SizedBox(height: 30.h),
          CustomTextField(
            width: double.infinity,
            controller: _controllerSearch,
            placeholder: 'Cari Bank Sampah Organik',
            suffixIcon: Icons.search,
            onSuffixTap: () {},
            radius: 10.w,
            shadow: false,
            fieldColor: Color(0xFFF2F2F0),
          ),
        ],
      ),
    );
  }
}
