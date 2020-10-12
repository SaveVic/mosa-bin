import 'package:flutter/material.dart';
import 'package:mosa_bin/screens/home/style_home.dart';

class MenuHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
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
        ),
      ],
    );
  }
}
