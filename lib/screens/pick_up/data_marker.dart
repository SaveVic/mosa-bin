// const List<Map> dataMarker = [
//   {
//     'id': 'm1',
//     'lat': -7.7774087,
//     'long': 110.3742344,
//     'name': 'Bank sampah pertama',
//     'daerah': 'Sukadoi',
//     'pj': 'Pengurus',
//     'kontak': 08123548890,
//     'alamat': 'RT.13, Sukadoi, Bandung',
//     'sampah': [
//       {
//         'jenis': 'Taman',
//         'harga': 1000,
//       },
//       {
//         'jenis': 'Sisa Makanan',
//         'harga': 1500,
//       },
//     ],
//   },
//   {
//     'id': 'm2',
//     'lat': -7.7712857,
//     'long': 110.3974086,
//     'name': 'Bank sampah kedua',
//     'daerah': 'Sukaanda',
//     'pj': 'Mahasiswa',
//     'kontak': 08125678890,
//     'alamat': 'RT.14, Sukaanda, Bandung',
//     'sampah': [
//       {
//         'jenis': 'Taman',
//         'harga': 1500,
//       },
//       {
//         'jenis': 'Sisa Makanan',
//         'harga': 1000,
//       },
//     ],
//   },
//   {
//     'id': 'm3',
//     'lat': -7.7901646,
//     'long': 110.3887397,
//     'name': 'Bank sampah ketiga',
//     'daerah': 'Suka-suka',
//     'pj': 'Dosen',
//     'kontak': 08243438890,
//     'alamat': 'RT.14, Suka-suka, Bandung',
//     'sampah': [
//       {
//         'jenis': 'Taman',
//         'harga': 1200,
//       },
//       {
//         'jenis': 'Sisa Makanan',
//         'harga': 1800,
//       },
//     ],
//   }
// ];

// class DataMarker {
//   String id;
//   double lat;
//   double long;
//   String name;
//   String region;
//   String pj;
//   int contact;
//   String address;
//   List<TrashInfo> trashInfo;

//   // this.id,
//   // this.lat,
//   // this.long,
//   // this.name,
//   // this.region,
//   // this.pj,
//   // this.contact,
//   // this.address,
//   // this.trashInfo,

//   DataMarker([
//     this.id,
//     this.lat,
//     this.long,
//     this.name,
//     this.region,
//     this.pj,
//     this.contact,
//     this.address,
//     this.trashInfo,
//   ]);

//   DataMarker.fromMap(Map m) {
//     this.id = m['id'];
//     this.lat = m['lat'];
//     this.long = m['long'];
//     this.name = m['name'];
//     this.region = m['daerah'];
//     this.pj = m['pj'];
//     this.contact = m['kontak'];
//     this.address = m['alamat'];
//     this.trashInfo = List<TrashInfo>.generate(
//         m['sampah'].length, (i) => TrashInfo.fromMap(m['sampah'][i]));
//   }
// }

// class TrashInfo {
//   String type;
//   int price;

//   TrashInfo(this.type, this.price);

//   TrashInfo.fromMap(Map m) {
//     this.type = m['jenis'];
//     this.price = m['harga'];
//   }
// }
