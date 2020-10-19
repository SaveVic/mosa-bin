// import 'package:cloud_firestore/cloud_firestore.dart';

class TrashRecord {
  final String tipe;
  final int harga;
  final int reference;

  TrashRecord(this.tipe, this.harga, this.reference);

  TrashRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['tipe'] != null),
        assert(map['harga'] != null),
        tipe = map['tipe'],
        harga = map['harga'];

  // TrashRecord.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Sampah<$tipe: $harga>";
}
