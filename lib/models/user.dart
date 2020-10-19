import 'dart:convert';

class UserData {
  String _username;
  int _id;
  bool _done_intro;

  bool get done_intro => _done_intro;
  String get username => _username;
  int get id => _id;

  UserData([this._username, this._id, this._done_intro = false]);

  UserData.fromMap(var map) {
    _id = map['id'];
    _username = map['username'];
    _done_intro = map['done_intro'];
  }

  String toJSON() => jsonEncode(
        {'id': id, 'username': username, 'done_intro': done_intro},
      );
}
