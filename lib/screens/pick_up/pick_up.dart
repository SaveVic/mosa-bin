import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:mosa_bin/components/bottom_navbar.dart';
import 'package:mosa_bin/components/custom_button.dart';
import 'package:mosa_bin/components/custom_textfield.dart';

import 'data_marker.dart';

class PickUpPage extends StatefulWidget {
  @override
  _PickUpPageState createState() => _PickUpPageState();
}

class _PickUpPageState extends State<PickUpPage> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _controllerAddress = TextEditingController();

  final TextStyle _textStyle = TextStyle(
    fontSize: 12.sp,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  static const LatLng _center = const LatLng(-7.7811505, 110.3791267);
  bool _showInfo = false;
  DataMarker _dataShowed = DataMarker();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<Set<Marker>> initMarkers() async {
    List<DataMarker> data = List<DataMarker>.generate(
        dataMarker.length, (i) => DataMarker.fromMap(dataMarker[i]));
    Set<Marker> _markers = {};
    for (DataMarker d in data) {
      _markers.add(
        Marker(
          markerId: MarkerId(d.id),
          position: LatLng(d.lat, d.long),
          onTap: () {
            _showInfoDialog(d);
          },
        ),
      );
    }
    return _markers;
  }

  void _showInfoDialog(DataMarker d) {
    setState(() {
      _showInfo = true;
      _dataShowed = d;
    });
  }

  void _showPriceInfoDialog(BuildContext ctx) {
    List<TrashInfo> tInfo = _dataShowed.trashInfo;
    List<Widget> temp = [
      Text(
        '${_dataShowed.name}\n${_dataShowed.region}',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 10.h),
    ];
    temp.addAll(
      List<Widget>.generate(
        tInfo.length,
        (i) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('1 Kg Sampah ${tInfo[i].type}'),
            Text(': Rp.${tInfo[i].price}/kg'),
          ],
        ),
      ),
    );
    showDialog(
      context: ctx,
      child: AlertDialog(
        content: Container(
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: temp,
          ),
        ),
      ),
    );
  }

  Future<bool> _showPickUpDialog(BuildContext ctx) async {
    bool t = await showDialog(
          context: ctx,
          barrierDismissible: false,
          child: AlertDialog(
            content: Container(
              padding: EdgeInsets.all(10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                        size: 40.h,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: Column(
                            children: [
                              Text(
                                'Alamat Bank Sampah',
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                              Text(
                                '${_dataShowed.address}',
                                style: TextStyle(
                                    fontSize: 12.sp, color: Color(0xFFA9A9A9)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                        size: 40.h,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: TextField(
                            controller: _controllerAddress,
                            decoration: InputDecoration(
                              hintText: 'Alamat Penjemputan',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                    color: Color(0xFF6A9923),
                    width: 80.w,
                    height: 30.h,
                    text: Text(
                      'Lanjut',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx, true);
                    },
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
    return t;
  }

  Future<bool> _showChooseKurirDialog(BuildContext ctx) async {
    bool t = await showDialog(
          context: ctx,
          barrierDismissible: false,
          child: AlertDialog(
            content: Container(
              padding: EdgeInsets.all(10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Pilih Kurir',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black),
                  ),
                  SizedBox(height: 10.h),
                  RadioButtonGroup(
                    labels: <String>[
                      'Kurir bank sampah',
                      'Go Send',
                    ],
                    onSelected: (String selected) {},
                  ),
                  SizedBox(height: 15.h),
                  CustomButton(
                    color: Color(0xFF6A9923),
                    width: 80.w,
                    height: 30.h,
                    text: Text(
                      'Jemput',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx, true);
                    },
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
    return t;
  }

  void _showPickUpSuccessDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Proses penjemputan berhasil,\nsilahkan tunggu kurir !',
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
    return MaterialApp(
      home: Scaffold(
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            FutureBuilder<Set<Marker>>(
              future: initMarkers(),
              builder: (_, snap) {
                if (snap.data != null)
                  return GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 14.0,
                    ),
                    markers: snap.data,
                  );
                else
                  return Container();
              },
            ),
            // GoogleMap(
            //   onMapCreated: _onMapCreated,
            //   initialCameraPosition: CameraPosition(
            //     target: _center,
            //     zoom: 14.0,
            //   ),
            //   markers: _markers,
            // ),
            Container(
              margin: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              alignment: Alignment.topCenter,
              child: CustomTextField(
                width: double.infinity,
                controller: null,
                placeholder: 'Cari (Bank Sampah kota/kabupaten)',
                suffixIcon: Icons.search,
                onSuffixTap: () {},
                radius: 10.w,
                shadow: false,
              ),
            ),
            (_showInfo) ? buildLocInformation(context) : Container(),
          ],
        ),
        bottomNavigationBar: MainBottomNavBar(
          pos: 0,
          onSelected: (id) {
            Navigator.pop(context, id);
          },
        ),
      ),
    );
  }

  Column buildLocInformation(BuildContext ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_dataShowed.name, style: _textStyle),
              Text(_dataShowed.region, style: _textStyle),
              Text('Penanggung Jawab : ${_dataShowed.pj}', style: _textStyle),
              Text('Kontak : ${_dataShowed.contact}', style: _textStyle),
              Text('Alamat : ${_dataShowed.address}', style: _textStyle),
              SizedBox(height: 16.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    color: Color(0xFFF9B915),
                    width: 140.w,
                    height: 30.h,
                    text: Text(
                      'Cek Harga',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () {
                      _showPriceInfoDialog(ctx);
                    },
                  ),
                  CustomButton(
                    color: Color(0xFF6A9923),
                    width: 140.w,
                    height: 30.h,
                    text: Text(
                      'Jemput Sampah',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () async {
                      bool res = await _showPickUpDialog(context) ?? false;
                      if (res)
                        res = await _showChooseKurirDialog(context) ?? false;
                      if (res) _showPickUpSuccessDialog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
        'Jemput Sampah',
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
