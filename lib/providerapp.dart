import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String name = "";
  String email = "";

  void login(String n, String e) {
    name = n;
    email = e;
    notifyListeners();
  }

  void logout() {
    name = "MegaDevices";
    email = "MegaDevices@gmail.com";
    notifyListeners();
  }

}