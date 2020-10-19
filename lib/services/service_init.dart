import 'package:mosa_bin/db/dbhelper.dart';
import 'package:mosa_bin/models/db_loc.dart';
import 'package:mosa_bin/models/db_trash.dart';
import 'package:mosa_bin/models/db_user.dart';

class ServiceInit {
  final DBHelper helper = DBHelper();
  final UserDB user =
      UserDB('admin', 'admin', '', '01012020', 'admin', '', 10, 15, 100000);

  final List<LocDB> loc = [
    LocDB('Lokasi 1', 'Bandung', 'Warga', '081122223333',
        'Kelurahan Babakan Sari, Bandung', -6.9244658, 107.6475208),
    LocDB('Lokasi 2', 'Bandung', 'Warga', '081122223333',
        'Kelurahan Kujang Sari, Bandung', -6.9626952, 107.645434),
    LocDB('Lokasi 3', 'Bandung', 'Warga', '081122223333',
        'Kelurahan Sukamiskin, Bandung', -6.9098953, 107.6746083),
    LocDB('Lokasi 4', 'Bandung', 'Warga', '081122223333',
        'Kelurahan Cihaurgeulis, Bandung', -6.9016973, 107.6257449),
    LocDB('Lokasi 5', 'Bandung', 'Warga', '081122223333',
        'Kelurahan Sukaluyu, Bandung', -6.8955657, 107.6258406),
    LocDB('Lokasi 6', 'Bandung', 'Warga', '081122223333',
        'Kelurahan Gempol Sari, Bandung', -6.9290437, 107.5569019),
    LocDB('Lokasi 7', 'Bandung', 'Warga', '081122223333',
        'Kelurahan Neglasari, Bandung', -6.8938044, 107.6346331),
    LocDB('Lokasi 8', 'Bandung', 'Warga', '081122223333',
        'Kelurahan Kebon Pisang, Bandung', -6.9187616, 107.6166648),
  ];

  final List<TrashDB> trash = [
    TrashDB('Taman', 1500),
    TrashDB('Makanan', 1100),
  ];

  Future<void> initData() async {
    await helper.insertUser(user);
    for (LocDB v in loc) await helper.insertLoc(v);
    for (TrashDB v in trash) await helper.insertTrash(v);
  }
}
