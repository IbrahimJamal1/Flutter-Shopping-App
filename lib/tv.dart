import 'package:flutter/material.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/providerapp.dart';
import 'package:provider/provider.dart';

class Tv extends StatelessWidget {
  const Tv({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: tvDev.length,
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
                  tvDev[index]["imag"],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Text(tvDev[index]["name"]),
              Text("${tvDev[index]["price"]} \$"),
              MaterialButton(
                onPressed: () {
                  context.read<CartProvider>().addcart(
                    tvDev[index]["price"],
                    tvDev[index]["name"],
                    tvDev[index]["imag"],
                    
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
