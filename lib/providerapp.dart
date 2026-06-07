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
  String price = "";
  String name = "";
  String pathimg = "";

  List<Map<String, dynamic>> cartItems = [];

  void addcart(dynamic price, String name, String image) {
    
    cartItems.add({"price": price, "name": name, "image": image});
    
    notifyListeners();
  }

  void clearcart() {
    cartItems.clear();
    notifyListeners();
  }

 int totalPrice() {
    int total = 0;

    for (var item in cartItems) {
      total +=int.parse(item["price"]);
    }

    return total  ;
  }

}
