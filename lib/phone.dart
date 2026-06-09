import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/providerapp.dart';
import 'package:provider/provider.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  List products = [];
  @override
   
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var data = await FirebaseFirestore.instance
    .collection('Products')
    .where('type', isEqualTo: 'Phone')
    .get();
    setState(() {
      products = data.docs;
    });

  }

   Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// IMAGE
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    products[index]["imag"],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// NAME
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  products[index]["name"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              /// PRICE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "${products[index]["price"]} \$",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// BUTTON
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    context.read<CartProvider>().addcart(
                      products[index]["price"],
                      products[index]["name"],
                      products[index]["imag"],
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to cart ✅"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  color: const Color(0xFF0D47A1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  
  }

}