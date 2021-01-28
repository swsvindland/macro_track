import 'package:MacroTrack/models/loginModel.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class Store extends ChangeNotifier {
  LoginModel _login;
  LoginModel get login => _login;

  void setLogin(LoginModel login) {
    _login = login;
    notifyListeners();
  }

  User _user;
  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  bool _updating = false;
  bool get updating => _updating;

  void setUpdating(bool updating) {
    _updating = updating;
    notifyListeners();
  }
}
