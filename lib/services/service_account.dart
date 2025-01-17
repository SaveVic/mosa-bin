// import 'package:firebase_auth/firebase_auth.dart';
import 'package:mosa_bin/db/dbhelper.dart';
import 'package:mosa_bin/models/db_user.dart';
import 'package:mosa_bin/models/shared_pref.dart';
import 'package:mosa_bin/models/user.dart';

class ServiceAccount {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  final SharedPreferencesHelper helper = SharedPreferencesHelper();
  final DBHelper dbHelper = DBHelper();

  Future<UserDB> getAccountInfoDatabase() async {
    UserData data = await helper.getData();
    UserDB user = await dbHelper.findUser(data.username);
    return user;
  }

  Future<void> changeNickname(UserDB user, String newnick) async {
    user.nickname = newnick;
    await dbHelper.updateUser(user);
  }

  Future<void> changeAva(UserDB user, String path) async {
    user.fotoPath = path;
    await dbHelper.updateUser(user);
  }

  Future<void> addCash(int value) async {
    UserData user = await helper.getData();
    UserDB temp = await dbHelper.findUser(user.username);
    temp.cash += value;
    await dbHelper.insertUser(temp);
  }

  Future<void> logoutDatabase() async {
    await helper.setData(UserData(null, null, true));
  }
}
