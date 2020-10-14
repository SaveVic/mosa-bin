import 'package:flutter/material.dart';
import 'package:mosa_bin/components/bottom_navbar.dart';
import 'package:mosa_bin/components/custom_button.dart';

class TrashBinPage extends StatefulWidget {
  @override
  _TrashBinPageState createState() => _TrashBinPageState();
}

class _TrashBinPageState extends State<TrashBinPage> {
  TextStyle _normalStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  TextStyle _boldStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF6A9923),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Mosa Smart Bin',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(
        pos: 0,
        onSelected: (id) {
          Navigator.pop(context, id);
        },
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'Silahkan scan barcode yang ada pada\nsampah botolmu !',
              textAlign: TextAlign.center,
              style: _boldStyle,
            ),
            SizedBox(height: 40),
            Text('Botol Ades Rp. 80', style: _normalStyle),
            Text('Botol Non Ades Rp. 50', style: _normalStyle),
            SizedBox(height: 50),
            Icon(
              Icons.qr_code_scanner,
              size: 250,
              color: Colors.black.withOpacity(0.5),
            ),
            SizedBox(height: 50),
            CustomButton(
              color: Color(0xFFF9B915),
              width: 140,
              height: 45,
              text: Text(
                'Scan Barcode',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
