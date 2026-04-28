import 'package:flutter/material.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/providerapp.dart';
import 'package:provider/provider.dart';

class Phone extends StatelessWidget {
  const Phone({super.key});

  @override
   Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: phoneDev.length,
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
                  phoneDev[index]["imag"],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Text(phoneDev[index]["name"]),
              Text("${phoneDev[index]["price"]} \$"),
              MaterialButton(
                onPressed: () {
                  context.read<CartProvider>().addcart(
                    phoneDev[index]["price"],
                    phoneDev[index]["name"],
                    phoneDev[index]["imag"],
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Added to cart ✅"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                color: Colors.blue,
                minWidth: double.infinity,
                child: Text(
                  "Add Cart",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}