import 'package:flutter/material.dart';
import 'package:ecommerce/main.dart';

class Phone extends StatelessWidget {
  const Phone({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: phoneDev.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    phoneDev[index]["imag"],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  phoneDev[index]["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "${phoneDev[index]["price"]} \$",
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // add to cart
                  },
                  child: const Text("Add to cart"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}