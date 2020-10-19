// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosa_bin/db/dbhelper.dart';
import 'package:mosa_bin/models/db_loc.dart';
import 'package:mosa_bin/models/db_trash.dart';
import 'package:mosa_bin/models/record_loc.dart';
import 'package:mosa_bin/models/record_trash.dart';

class ServiceLocation {
  // final FirebaseFirestore reference = FirebaseFirestore.instance;
  final DBHelper dbHelper = DBHelper();
  final Function(LocationRecord) onShowInfoDialog;

  ServiceLocation(this.onShowInfoDialog);

  // Future<Set<Marker>> getMarkersFirebase() async {
  //   // await Future.delayed(Duration(milliseconds: 10));
  //   Set<Marker> _markers = {};
  //   var snapshots = await reference.collection('bank_sampah').get();
  //   for (QueryDocumentSnapshot data in snapshots.docs) {
  //     LocationRecord loc = LocationRecord.fromSnapshot(data);
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId(data.id),
  //         position: LatLng(loc.lat, loc.long),
  //         onTap: () {
  //           onShowInfoDialog(loc);
  //         },
  //       ),
  //     );
  //   }
  //   return _markers;
  // }

  Future<Set<Marker>> getMarkersDatabase() async {
    // await Future.delayed(Duration(milliseconds: 10));
    Set<Marker> _markers = {};
    List<LocDB> locs = await dbHelper.getAllLoc();
    for (LocDB loc in locs) {
      _markers.add(
        Marker(
          markerId: MarkerId(loc.id.toString()),
          position: LatLng(loc.lat, loc.long),
          onTap: () {
            onShowInfoDialog(
              LocationRecord(
                loc.nama,
                loc.daerah,
                loc.pj,
                loc.kontak,
                loc.alamat,
                loc.lat,
                loc.long,
                null,
              ),
            );
          },
        ),
      );
    }
    return _markers;
  }

  // Future<List<TrashRecord>> getTrashInfoFirebase() async {
  //   QuerySnapshot qs = await reference.collection('sampah').get();
  //   List<TrashRecord> res = List<TrashRecord>.generate(
  //       qs.docs.length, (i) => TrashRecord.fromSnapshot(qs.docs[i]));
  //   return res;
  // }

  Future<List<TrashRecord>> getTrashInfoDatabase() async {
    List<TrashDB> trashs = await dbHelper.getAllTrash();
    List<TrashRecord> res = List<TrashRecord>.generate(
      trashs.length,
      (i) => TrashRecord(trashs[i].tipe, trashs[i].harga, null),
    );
    return res;
  }
}
