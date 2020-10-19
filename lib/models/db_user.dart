class UserDB {
  int id;
  String username;
  String password;
  String email;
  String birthDate;
  String nickname;
  String fotoPath;
  double totalWeight;
  int countBottle;
  int cash;

  UserDB(
    this.username,
    this.password,
    this.email,
    this.birthDate,
    this.nickname,
    this.fotoPath,
    this.totalWeight,
    this.countBottle,
    this.cash,
  );

  UserDB.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.username = map['username'] ?? '';
    this.password = map['password'] ?? '';
    this.email = map['email'] ?? '';
    this.birthDate = map['birthDate'] ?? '';
    this.nickname = map['nickname'] ?? '';
    this.fotoPath = map['fotoPath'] ?? '';
    this.totalWeight = map['totalWeight'] ?? -1;
    this.countBottle = map['countBottle'] ?? -1;
    this.cash = map['cash'] ?? -1;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'birthDate': birthDate,
      'nickname': nickname,
      'fotoPath': fotoPath,
      'totalWeight': totalWeight,
      'countBottle': countBottle,
      'cash': cash,
    };
  }
}
