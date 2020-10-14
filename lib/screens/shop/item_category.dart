import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  final String path;
  final String label;
  final double image_height = 140;
  final double label_cover_height = 100;
  final double label_size = 18;

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
        height: image_height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(path),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: label_cover_height,
          padding: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          color: Colors.white.withOpacity(0.73),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: label_size,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
