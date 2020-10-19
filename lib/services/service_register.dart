// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosa_bin/db/dbhelper.dart';
import 'package:mosa_bin/models/db_user.dart';
import 'package:mosa_bin/models/shared_pref.dart';
import 'package:mosa_bin/models/user.dart';
import 'package:mosa_bin/screens/register/date_parser.dart';

class RegisterValidatorData {
  bool validUsername;
  bool validPassword;
  bool validRePassword;
  bool validEmail;
  bool validBirthDate;
  bool result;
  String message;

  RegisterValidatorData({
    this.validUsername = true,
    this.validPassword = true,
    this.validRePassword = true,
    this.validEmail = true,
    this.validBirthDate = true,
    this.message = '',
    this.result = true,
  });
}

class ServiceRegister {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final FirebaseFirestore reference = FirebaseFirestore.instance;
  final SharedPreferencesHelper helper = SharedPreferencesHelper();
  final DBHelper dbHelper = DBHelper();

  RegisterValidatorData validator(
    String username,
    String password,
    String rePassword,
    String email,
    String birthDate,
  ) {
    RegisterValidatorData data = RegisterValidatorData();
    if (!DateParser.validateDisplay(birthDate) || birthDate.isEmpty) {
      data.validBirthDate = false;
      data.result = false;
      data.message = 'Birth Date tidak valid';
    }
    if (email.isEmpty) {
      data.validEmail = false;
      data.result = false;
      data.message = 'Email tidak boleh kosong';
    }
    if (rePassword != password) {
      data.validRePassword = false;
      data.validPassword = false;
      data.result = false;
      data.message = 'Password dan RePassword harus sama';
    }
    if (rePassword.isEmpty) {
      data.validRePassword = false;
      data.result = false;
      data.message = 'RePassword tidak boleh kosong';
    }
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

  // Future<void> registerWithFirebase(
  //   String username,
  //   String password,
  //   String rePassword,
  //   String email,
  //   String birthDate,
  // ) async {
  //   try {
  //     UserCredential user = await auth.createUserWithEmailAndPassword(
  //       email: '$username@mymosa.com',
  //       password: password,
  //     );
  //     await _createNewDataUser(username, email, birthDate, user.user.uid);
  //     await helper.setData(UserData(user.user.displayName, 0, true));
  //     onNavigate();
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'email-already-in-use' || e.code == 'invalid-email') {
  //       Fluttertoast.showToast(msg: 'Username sudah dipakai atau tidak valid');
  //     } else if (e.code == 'weak-password') {
  //       Fluttertoast.showToast(msg: 'Password minimal 6 karakter');
  //     } else {
  //       Fluttertoast.showToast(msg: 'Terjadi kesalahan');
  //     }
  //   }
  // }

  // Future<void> _createNewDataUser(
  //   String username,
  //   String email,
  //   String birthDate,
  //   String uid,
  // ) async {
  //   Map data = {
  //     'username': username,
  //     'email': email,
  //     'birthDate': DateParser.display2saved(birthDate),
  //     'nickname': '-',
  //     'trashWeight': 0,
  //     'countBottle': 0,
  //     'cash': 0,
  //   };
  //   await reference.collection('users').doc(uid).set(data);
  // }

  Future<bool> registerWithDatabase(
    String username,
    String password,
    String rePassword,
    String email,
    String birthDate,
  ) async {
    int check = await dbHelper.countUser(username);
    if (check > 0) {
      Fluttertoast.showToast(msg: 'Username sudah dipakai atau tidak valid');
      return false;
    }
    UserDB user = UserDB(username, password, email,
        DateParser.display2saved(birthDate), '-', '', 0, 0, 0);
    await dbHelper.insertUser(user);
    user = await dbHelper.findUser(username);
    await helper.setData(UserData(username, user.id, true));
    return true;
  }
}
