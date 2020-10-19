// import 'package:cloud_firestore/cloud_firestore.dart';

class LocationRecord {
  final String nama;
  final String daerah;
  final String pj;
  final String kontak;
  final String alamat;
  final double lat;
  final double long;
  final int reference;

  LocationRecord(
    this.nama,
    this.daerah,
    this.pj,
    this.kontak,
    this.alamat,
    this.lat,
    this.long,
    this.reference,
  );

  LocationRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nama'] != null),
        assert(map['lat'] != null),
        assert(map['long'] != null),
        nama = map['nama'],
        daerah = map['daerah'] ?? '-',
        pj = map['pj'] ?? '-',
        kontak = map['kontak'] ?? '-',
        alamat = map['alamat'] ?? '-',
        lat = map['lat'],
        long = map['long'];

  // LocationRecord.fromSnapshot(DocumentSnapshot snap)
  //     : this.fromMap(snap.data(), reference: snap.reference);

  @override
  String toString() {
    return 'Location<$lat, $long>';
  }
}
