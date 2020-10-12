import 'dart:convert';

class User {
  String _username;
  String _auth_token;
  bool _done_intro;

  bool get done_intro => _done_intro;
  String get username => _username;
  String get auth_token => _auth_token;

  User([this._username, this._auth_token, this._done_intro = false]);

  User.fromMap(var map) {
    _auth_token = map['auth_token'];
    _username = map['username'];
    _done_intro = map['done_intro'];
  }

  String toJSON() => jsonEncode(
        {
          'auth_token': auth_token,
          'username': username,
          'done_intro': done_intro
        },
      );
}
