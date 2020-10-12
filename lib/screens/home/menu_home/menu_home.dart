import 'package:flutter/material.dart';
import 'package:mosa_bin/components/button_home.dart';
import 'package:mosa_bin/screens/home/menu_home/news_item_home.dart';
import 'package:mosa_bin/screens/home/style_home.dart';

import 'item_home.dart';

class MenuHome extends StatelessWidget {
  final List<ItemHome> itemsMenu = [
    ItemHome('assets/images/icon_home/truck.png', 'Jemput Sampah'),
    ItemHome('assets/images/icon_home/trash.png', 'Mosa Smart Bin'),
    ItemHome('assets/images/icon_home/article.png', 'Artikel'),
    ItemHome('assets/images/icon_home/cart.png', 'Toko Produk Organik'),
  ];

  final List<ItemHome> itemsNews = [
    ItemHome('assets/images/news_img/news1.png',
        'Kali citarum, sungai tekotor\ndi dunia'),
    ItemHome(
        'assets/images/news_img/news2.png', 'Kangpisman Bandung\najak warga'),
  ];

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
                path: itemsNews[i].path,
                height: height * 0.16,
                title: itemsNews[i].desc,
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
          path: itemsMenu[i].path,
          descText: itemsMenu[i].desc,
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
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Container(
              width: width * 0.8,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Cari Bank Sampah Organik',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFFA9A9A9),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    size: 21,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
