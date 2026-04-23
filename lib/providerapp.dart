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

class CartProvider extends ChangeNotifier {
  String price = "" ;
  String name ="" ;
  String pathimg="";

  void addcart (String p,String n,String path){
    price=p;
    name=n;
    pathimg=path;
  }

}