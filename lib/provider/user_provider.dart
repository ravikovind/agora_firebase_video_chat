import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:video_call/models/user.dart';
import 'package:video_call/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  Userx _user;
  AuthMethods _authMethods = AuthMethods();

  Userx get getUser => _user;

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
    return currentUser;
  }

  Future<void> refreshUser() async {
    Userx user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
