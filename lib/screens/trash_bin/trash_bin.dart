import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosa_bin/components/bottom_navbar.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/screens/trash_bin/alert_bottle.dart';
import 'package:mosa_bin/services/service_account.dart';

class TrashBinPage extends StatefulWidget {
  @override
  _TrashBinPageState createState() => _TrashBinPageState();
}

enum Stage { Bottle, TrashBin }

class _TrashBinPageState extends State<TrashBinPage> {
  TextStyle _normalStyle = TextStyle(
    fontSize: 12.sp,
    color: Colors.black,
  );
  TextStyle _boldStyle = TextStyle(
    fontSize: 12.sp,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  ServiceAccount serv = ServiceAccount();

  Stage _stage = Stage.TrashBin;
  String _codeTrashBin = '';
  String _codeBottle = '';

  Future _onScanBottle(BuildContext ctx) async {
    var result = await BarcodeScanner.scan();
    String res = (result.type == ResultType.Barcode) ? result.rawContent : '';
    if (res.isEmpty) {
      Fluttertoast.showToast(msg: 'Gagal meng-scan botol');
      return;
    }
    setState(() {
      // _stage = Stage.TrashBin;
      _codeBottle = res;
    });
    bool t = await _showDialogBottle(ctx) ?? false;
    if (!t)
      Fluttertoast.showToast(msg: 'Coba lagi');
    else {
      _showDialogTrashSuccess(context);
      setState(() {
        _stage = Stage.TrashBin;
      });
    }
  }

  Future<bool> _showDialogBottle(BuildContext ctx) async {
    bool t = await showDialog(
          context: ctx,
          barrierDismissible: false,
          child: AlertWaitBottle(),
        ) ??
        false;
    return t;
  }

  Future _onScanTrash(BuildContext ctx) async {
    var result = await BarcodeScanner.scan();
    String res = (result.type == ResultType.Barcode) ? result.rawContent : '';
    if (res.isEmpty) {
      Fluttertoast.showToast(msg: 'Gagal meng-scan trash bin');
      return;
    }
    // _showDialogTrashSuccess(ctx);
    setState(() {
      _stage = Stage.Bottle;
      _codeTrashBin = res;
    });
  }

  void _showDialogTrashSuccess(BuildContext ctx) {
    print(_codeTrashBin);
    print(_codeBottle);
    int value = 50;
    if (_codeBottle == '725272730') value = 80;
    serv.addCash(value);
    showDialog(
      context: ctx,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Selamat Poin Kamu Telah Berhasil\ndi Tambahkan !',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            // Image.asset(
            //   'assets/images/icon_akun/litter.png',
            //   width: 100.w,
            // ),
            Icon(
              Icons.check,
              color: Color(0xFFADDB31),
              size: 100.w,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);
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
            fontSize: 14.0.sp,
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
        padding: EdgeInsets.fromLTRB(60.w, 40.h, 60.w, 0),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              (_stage == Stage.Bottle)
                  ? 'Silahkan scan barcode yang ada pada\nsampah botolmu !'
                  : 'Silahkan scan barcode yang ada pada\nMOSA Smart Bin',
              textAlign: TextAlign.center,
              style: _boldStyle,
            ),
            SizedBox(height: (_stage == Stage.Bottle) ? 20.h : 0),
            (_stage == Stage.Bottle)
                ? Text('Botol Ades Rp. 80', style: _normalStyle)
                : Container(),
            (_stage == Stage.Bottle)
                ? Text('Botol Non Ades Rp. 50', style: _normalStyle)
                : Container(),
            SizedBox(height: 30.h),
            Icon(
              Icons.qr_code_scanner,
              size: 190.w,
              color: Colors.black.withOpacity(0.5),
            ),
            SizedBox(height: 30.h),
            CustomButton(
              color: Color(0xFFF9B915),
              width: 130.w,
              height: 40.h,
              text: Text(
                'Scan Barcode',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                (_stage == Stage.Bottle)
                    ? _onScanBottle(context)
                    : _onScanTrash(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
