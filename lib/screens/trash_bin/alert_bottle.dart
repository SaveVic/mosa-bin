import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertWaitBottle extends StatefulWidget {
  @override
  _AlertWaitBottleState createState() => _AlertWaitBottleState();
}

class _AlertWaitBottleState extends State<AlertWaitBottle> {
  Timer _timer;
  int _start = 10;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start < 1) {
          _timer.cancel();
          Navigator.of(context).pop(true);
        } else {
          _start -= 1;
        }
      });
    });
  }

  String timertext() {
    int m = _start ~/ 60;
    int s = _start % 60;
    String mm = m.toString().padLeft(2, '0');
    String ss = s.toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Silahkan masukkan sampah botol\nmu ke dalam MOSA Smart Bin !',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Image.asset(
              'assets/images/icon_akun/litter.png',
              width: 100.w,
            ),
            SizedBox(height: 30.h),
            Text(
              'Sedang menunggu respon... ${timertext()}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
