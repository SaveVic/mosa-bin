import 'dart:convert';
import 'package:mosa_bin/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _kData = 'data';

  Future<UserData> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringData = prefs.getString(_kData) ?? '';
    UserData data = UserData(null, null);
    if (stringData.isEmpty) return data;
    try {
      data = UserData.fromMap(jsonDecode(stringData));
    } catch (e) {}
    return data;
  }

  Future<bool> setData(UserData value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == null) return await prefs.setString(_kData, '');
    String temp = '';
    try {
      temp = value.toJSON();
    } catch (e) {}
    return await prefs.setString(_kData, temp);
  }
}
