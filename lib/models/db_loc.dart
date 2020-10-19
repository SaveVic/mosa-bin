class LocDB {
  int id;
  String nama;
  String daerah;
  String pj;
  String kontak;
  String alamat;
  double lat;
  double long;

  LocDB(
    this.nama,
    this.daerah,
    this.pj,
    this.kontak,
    this.alamat,
    this.lat,
    this.long,
  );

  LocDB.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nama = map['nama'];
    this.daerah = map['daerah'];
    this.pj = map['pj'];
    this.kontak = map['kontak'];
    this.alamat = map['alamat'];
    this.lat = map['lat'];
    this.long = map['long'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'daerah': daerah,
      'pj': pj,
      'kontak': kontak,
      'alamat': alamat,
      'lat': lat,
      'long': long,
    };
  }
}
