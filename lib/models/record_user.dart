// import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecord {
  final String username;
  final String email;
  final String birthDate;
  final String nickname;
  final double trashWeight;
  final int countBottle;
  final int cash;
  final int reference;

  UserRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['username'] != null),
        username = map['username'],
        email = map['email'] ?? '-',
        birthDate = map['birthDate'] ?? '-',
        nickname = map['nickname'] ?? '-',
        trashWeight = map['trashWeight'] ?? 0,
        countBottle = map['countBottle'] ?? 0,
        cash = map['cash'] ?? 0;

  // UserRecord.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "User-$username";
}
