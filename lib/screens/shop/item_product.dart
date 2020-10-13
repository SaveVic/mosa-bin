import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final Map prod;

  const ItemProduct({Key key, @required this.prod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(prod['path']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            prod['label'],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            prod['owner'],
            style: TextStyle(
              fontSize: 9,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${prod['price']} / ${prod['unit']}',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.black,
                ),
              ),
              Text(
                '${prod['rating']}}',
                style: TextStyle(
                  fontSize: 9,
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
                  fontSize: 9,
                  color: Colors.black,
                ),
              ),
              Text(
                '${prod['sold']}} terjual',
                style: TextStyle(
                  fontSize: 9,
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
