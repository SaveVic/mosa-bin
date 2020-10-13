import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  final String path;
  final String label;

  const ItemCategory({Key key, @required this.path, @required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(path),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 64.0,
          padding: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          color: Colors.white.withOpacity(0.73),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
