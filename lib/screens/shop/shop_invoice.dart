import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool _errorAddress = false;

  bool _validate() {
    if (_controllerAddress.text.isNotEmpty) return true;
    return false;
  }

  void _onProcessTap(BuildContext ctx) {
    if (_validate())
      showDialog(
        context: ctx,
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pembelian anda telah\nBERHASIL!',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Icon(
                Icons.check,
                color: Color(0xFFADDB31),
                size: 100.w,
              ),
            ],
          ),
        ),
      );
    else {
      setState(() {
        _errorAddress = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);
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
            fontSize: 14.0.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
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
      padding: EdgeInsets.all(40.w),
      margin: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Alamat Pengiriman'),
          SizedBox(height: 20.h),
          TextField(
            controller: _controllerAddress,
            decoration: InputDecoration(
              hintText: 'Masukkan alamat pengiriman',
              labelText: 'Alamat',
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              errorText: (_errorAddress) ? 'Alamat tidak boleh kosong' : null,
            ),
          ),
          SizedBox(height: 20.h),
          Text('Pilih Metode Pembayaran'),
          SizedBox(height: 20.h),
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
              height: 25.h,
              width: 80.w,
              color: Color(0xFFF9B915),
              text: Text(
                'Proses',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _onProcessTap(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
