import 'package:flutter/material.dart';
import 'package:mosa_bin/screens/home/menu_home/item_home_main.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/screens/home/menu_home/item_home_news.dart';
import 'package:mosa_bin/screens/home/style_home.dart';
import 'package:mosa_bin/screens/shop/shop_browse.dart';
import 'package:mosa_bin/screens/trash_bin/trash_bin.dart';
import 'package:page_transition/page_transition.dart';

import 'data_home.dart';

class MenuHome extends StatelessWidget {
  final Function(int) onSetState;
  final TextEditingController _controllerSearch = TextEditingController();

  MenuHome({Key key, @required this.onSetState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTopBar(height),
        buildHomeItem(context, height),
        buildNewsFeed(height, width),
      ],
    );
  }

  void _navigateMain(BuildContext ctx, String page) async {
    int res = await Navigator.push(
          ctx,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: (page == 'jemput')
                ? ShopBrowsePage() // Jemput Page
                : (page == 'trash')
                    ? TrashBinPage()
                    : (page == 'article')
                        ? ShopBrowsePage() // Article Page
                        : ShopBrowsePage(),
          ),
        ) ??
        0;
    onSetState(res);
  }

  Container buildNewsFeed(double height, double width) {
    return Container(
      color: StyleHome.newsColor,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Berita Terbaru',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemsNews.length,
              itemBuilder: (ctx, i) {
                return ItemHomeNews(
                  path: itemsNews[i]['path'] ?? '',
                  height: height * 0.16,
                  width: width * 0.6,
                  title: itemsNews[i]['title'] ?? '',
                  titleColor: Color(0xFF595454),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Container buildHomeItem(BuildContext context, double height) {
    return Container(
      width: double.infinity,
      child: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shrinkWrap: true,
        crossAxisSpacing: 70,
        mainAxisSpacing: 50,
        crossAxisCount: 2,
        children: List<Widget>.generate(
          itemsMenu.length,
          (i) => ItemHomeMain(
            path: itemsMenu[i]['path'] ?? '',
            descText: itemsMenu[i]['label'] ?? '',
            descColor: Color(0xFF595454),
            color: StyleHome.baseColor,
            size: 90,
            onPressed: () {
              _navigateMain(context, itemsMenu[i]['nav'] ?? '');
            },
          ),
        ),
      ),
    );
  }

  Container buildTopBar(double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
      decoration: BoxDecoration(
        color: StyleHome.baseColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            StyleHome.logoPath,
            height: height * StyleHome.heightFactor,
          ),
          SizedBox(height: 30),
          CustomTextField(
            width: double.infinity,
            controller: _controllerSearch,
            placeholder: 'Cari Bank Sampah Organik',
            suffixIcon: Icons.search,
            onSuffixTap: () {},
            radius: 10,
            shadow: false,
            fieldColor: Color(0xFFF2F2F0),
          ),
        ],
      ),
    );
  }
}
