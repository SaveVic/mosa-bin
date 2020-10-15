import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Set<Marker> _markers = {};

  final TextStyle _textStyle = TextStyle(
    fontSize: 12.sp,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  static const LatLng _center = const LatLng(-7.7811505, 110.3791267);
  bool _showInfo = false;
  String _name;
  String _area;
  String _pj;
  String _contact;
  String _address;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    for (Map m in dataMarker) {
      _markers.add(
        Marker(
          markerId: m['id'],
          position: LatLng(m['lat'], m['long']),
          onTap: () {
            setState(() {
              _showInfo = true;
              _name = m['name'];
              _area = m['daerah'];
              _pj = m['pj'];
              _contact = m['kontak'];
              _address = m['alamat'];
            });
          },
        ),
      );
    }
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
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
            ),
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
            (_showInfo)
                ? Container(
                    padding: EdgeInsets.all(20.w),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_name, style: _textStyle),
                        Text(_area, style: _textStyle),
                        Text('Penanggung Jawab : $_pj', style: _textStyle),
                        Text('Kontak : $_contact', style: _textStyle),
                        Text('Alamat : $_address', style: _textStyle),
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
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
