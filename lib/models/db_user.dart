class UserDB {
  int id;
  String username;
  String password;
  String email;
  String birthDate;
  String nickname;
  String fotoPath;
  int trashWeight;
  int countBottle;
  int cash;

  UserDB(
    this.username,
    this.password,
    this.email,
    this.birthDate,
    this.nickname,
    this.fotoPath,
    this.trashWeight,
    this.countBottle,
    this.cash,
  );

  UserDB.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.username = map['username'];
    this.password = map['password'];
    this.email = map['email'];
    this.birthDate = map['birthDate'];
    this.nickname = map['nickname'];
    this.fotoPath = map['fotoPath'];
    this.trashWeight = map['trashWeight'];
    this.countBottle = map['countBottle'];
    this.cash = map['cash'];
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
      'trashWeight': trashWeight,
      'countBottle': countBottle,
      'cash': cash,
    };
  }
}
