import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providerapp.dart';

class Mycart extends StatelessWidget {
  const Mycart({super.key});
  @override
  Widget build(BuildContext context) {
    final prod = context.watch<CartProvider>();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            
            Card(
              child: Expanded(
                child: Image.asset(
                  prod.pathimg,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Text(prod.name, style: TextStyle(fontSize: 25)),

            Text("${prod.price} ", style: TextStyle(fontSize: 25)),

            MaterialButton(
              color: Colors.blue,
              child: Text("buy now", style: TextStyle(fontSize: 22)),
              onPressed: () {
                confirmation(context, prod.price);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void confirmation(BuildContext context, String n) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("confirmation", style: TextStyle(color: Colors.red)),
        content: Text("you buyment the $n ", style: TextStyle(fontSize: 25)),
        icon: Icon(Icons.warning),
        actions: [
          MaterialButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Successful Buyment✅"),
                  duration: Duration(seconds: 1),
                ),
              );
              Navigator.pushReplacementNamed(context, "home");
            },
            child: Text(
              "ok",
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
          ),
        ],
      );
    },
  );
}
