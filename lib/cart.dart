import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providerapp.dart';

class Mycart extends StatelessWidget {


  Mycart({super.key});

  @override
  Widget build(BuildContext context) {
    
    final prod = context.watch<CartProvider>();
    final user = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D47A1),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: prod.cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          prod.cartItems[index]["image"],
                        ),
                      ),
                      Text(
                        prod.cartItems[index]["name"],
                      ),
                      Text(
                        prod.cartItems[index]["price"].toString(),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const Spacer(),

            /// BUY BUTTON + DIALOG INLINE
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Row(
                          children: [
                            Icon(Icons.shopping_cart_checkout, color: Colors.green),
                            SizedBox(width: 10),
                            Text("Confirm Purchase"),
                          ],
                        ),
                        content: Text(
                          "Are you sure you want to buy ${prod.totalPrice()} EGP? ${user.email} ",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {

                              CollectionReference sales = FirebaseFirestore.instance.collection('sales');

                              for (var i = 0; i < prod.cartItems.length; i++) {
                                sales.add({
                                'name': prod.cartItems[i]["name"],
                                'price': prod.cartItems[i]["price"].toString(),
                                'email':user.email,
                                'nameuser':user.name,
                                });
                              }

                              Navigator.pop(context);
                              prod.clearcart();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Purchase Successful ✅"),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              Navigator.pushReplacementNamed(context, "home");
                            
                            },
                            child: const Text("Confirm"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  "Buy Now",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}