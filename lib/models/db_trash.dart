class TrashDB {
  int id;
  String tipe;
  int harga;

  TrashDB(
    this.tipe,
    this.harga,
  );

  TrashDB.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.tipe = map['tipe'];
    this.harga = map['harga'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipe': tipe,
      'harga': harga,
    };
  }
}
