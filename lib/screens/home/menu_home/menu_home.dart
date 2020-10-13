import 'package:flutter/material.dart';
import 'package:mosa_bin/components/button_home.dart';
import 'package:mosa_bin/components/custom_textfield.dart';
import 'package:mosa_bin/screens/home/menu_home/news_item_home.dart';
import 'package:mosa_bin/screens/home/style_home.dart';

import 'data_home.dart';

class MenuHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildTopBar(width),
        buildHomeItem(),
        buildNewsFeed(height),
      ],
    );
  }

  Container buildNewsFeed(double height) {
    return Container(
      color: StyleHome.newsColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Berita Terbaru',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemsNews.length,
            itemBuilder: (ctx, i) {
              return ItemNewsHome(
                path: itemsNews[i]['path'] ?? '',
                height: height * 0.16,
                title: itemsNews[i]['title'] ?? '',
                titleColor: Color(0xFF595454),
              );
            },
          )
        ],
      ),
    );
  }

  GridView buildHomeItem() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 20,
      mainAxisSpacing: 50,
      crossAxisCount: 2,
      children: List<Widget>.generate(
        itemsMenu.length,
        (i) => ButtonHomeItem(
          path: itemsMenu[i]['path'] ?? '',
          descText: itemsMenu[i]['label'] ?? '',
          descColor: Color(0xFF595454),
          color: StyleHome.baseColor,
          size: 30,
          onPressed: () {},
        ),
      ),
    );
  }

  Container buildTopBar(double width) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: StyleHome.baseColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            StyleHome.logoPath,
            width: width * StyleHome.widthFactor,
          ),
          SizedBox(height: 30),
          CustomTextField(
            width: double.infinity,
            controller: null,
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
