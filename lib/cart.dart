import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providerapp.dart';

class Mycart extends StatelessWidget {
  const Mycart({super.key});

  @override
  Widget build(BuildContext context) {
    final prod = context.watch<CartProvider>();

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

            /// PRODUCT CARD
            Container(
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
                children: [

                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      prod.pathimg,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    prod.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "${prod.price} EGP",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),
                ],
              ),
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
                          "Are you sure you want to buy ${prod.name} for ${prod.price} EGP?",
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
                              Navigator.pop(context);

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