import 'package:flutter/material.dart';
import 'package:ecommerce/main.dart';

class Tv extends StatelessWidget {
  const Tv({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: Prodects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  Prodects[index]["imag"],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Text(Prodects[index]["name"]),
              Text("${Prodects[index]["price"]} \$"),
              MaterialButton(
                onPressed: () {
                  //my cart
                },
                color: Colors.blue,
                minWidth: 1000,

                child: Text(
                  "add cart",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
