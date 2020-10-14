import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:mosa_bin/components/bottom_navbar.dart';
import 'package:mosa_bin/components/custom_button.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  BoxDecoration _outerBox = BoxDecoration(
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
  );

  TextEditingController _controllerAddress = TextEditingController();

  void _onProcessTap() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  'Pembelian anda telah\nBERHASIL!',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Icon(
                  Icons.check,
                  color: Color(0xFFADDB31),
                  size: 100,
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F0),
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
          'Toko Produk Organik',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            buildPaymentDetails(),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(
        pos: 0,
        onSelected: (id) {
          Navigator.pop(context, id);
        },
      ),
    );
  }

  Container buildPaymentDetails() {
    return Container(
      width: double.infinity,
      decoration: _outerBox,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Text('Alamat Pengiriman'),
          TextField(
            controller: _controllerAddress,
            decoration: InputDecoration(
              hintText: 'Masukkan alamat pengiriman',
              labelText: 'Alamat',
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          Text('Pilih Metode Pembayaran'),
          RadioButtonGroup(
            labels: <String>[
              'Bank Transfer',
              'Menggunakan Poin',
            ],
            onSelected: (String selected) {},
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: CustomButton(
              height: 30,
              width: 80,
              color: Color(0xFFF9B915),
              text: Text(
                'Proses',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
              onPressed: _onProcessTap,
            ),
          ),
        ],
      ),
    );
  }
}
