import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  String? _uid;

  User? get user => _user;
  String? get uid => _uid;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  void setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }
}
