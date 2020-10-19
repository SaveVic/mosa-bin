// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosa_bin/db/dbhelper.dart';
import 'package:mosa_bin/models/db_user.dart';
import 'package:mosa_bin/models/shared_pref.dart';
import 'package:mosa_bin/models/user.dart';

class LoginValidatorData {
  bool validUsername;
  bool validPassword;
  bool result;
  String message;

  LoginValidatorData({
    this.validUsername = true,
    this.validPassword = true,
    this.message = '',
    this.result = true,
  });
}

class ServiceLogin {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  final SharedPreferencesHelper helper = SharedPreferencesHelper();
  final DBHelper dbHelper = DBHelper();

  LoginValidatorData validator(String username, String password) {
    LoginValidatorData data = LoginValidatorData();
    if (password.isEmpty) {
      data.validPassword = false;
      data.result = false;
      data.message = 'Password tidak boleh kosong';
    }
    if (username.isEmpty) {
      data.validUsername = false;
      data.result = false;
      data.message = 'Username tidak boleh kosong';
    }
    return data;
  }

  // Future<void> loginWithFirebase(String username, String password) async {
  //   try {
  //     UserCredential user = await auth.signInWithEmailAndPassword(
  //       email: '$username@mymosa.com',
  //       password: password,
  //     );
  //     await helper.setData(
  //       UserData(username, 0, true),
  //     );
  //     onNavigate();
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'Username atau Password salah');
  //   }
  // }

  Future<bool> loginWithDatabase(String username, String password) async {
    int temp = await dbHelper.authUser(username, password);
    if (temp <= 0) {
      Fluttertoast.showToast(msg: 'Username atau Password salah');
      return false;
    } else {
      UserDB user = await dbHelper.findUser(username);
      await helper.setData(UserData(username, user.id, true));
      return true;
    }
  }
}
