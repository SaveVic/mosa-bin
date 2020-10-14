import 'package:flutter/material.dart';

class ItemTestimoni extends StatelessWidget {
  final String user;
  final String msg;

  const ItemTestimoni({Key key, this.user, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.person_outline, size: 40, color: Colors.black),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              '$user\n$msg',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
