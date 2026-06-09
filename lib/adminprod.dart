import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  final TextEditingController nameprod = TextEditingController();
  final TextEditingController priceprod = TextEditingController();
  final TextEditingController imagprod = TextEditingController();
  final productkey = GlobalKey<FormState>();
  String typeprod = "Laptop";  

  CollectionReference products = FirebaseFirestore.instance.collection('Products');

  
  Future <void> addproduct() async {
    await products.add({
    'name': nameprod.text,
    'price': double.parse(priceprod.text),
    'imag': imagprod.text,
    'type': typeprod, // Laptop أو Phone أو TV
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Products",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),

            child: Form(
              key: productkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Icon(
                    Icons.inventory_2,
                    size: 70,
                    color: Colors.blue,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Add Product",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Radio Buttons
                  RadioListTile(
                    title: Text("Laptop"),
                    value: "Laptop",
                    groupValue: typeprod,
                    onChanged: (value) {
                      setState(() {
                        typeprod = value!;
                      });
                    },
                  ),

                  RadioListTile(
                    title: Text("Phone"),
                    value: "Phone",
                    groupValue: typeprod,
                    onChanged: (value) {
                      setState(() {
                        typeprod = value!;
                      });
                    },
                  ),

                  RadioListTile(
                    title: Text("TV"),
                    value: "TV",
                    groupValue: typeprod,
                    onChanged: (value) {
                      setState(() {
                        typeprod = value!;
                      });
                    },
                  ),

                  SizedBox(height: 15),

                  // Name
                  TextFormField(
                    controller: nameprod,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Product Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Product Name",
                      prefixIcon: Icon(Icons.shopping_bag),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Price
                  TextFormField(
                    controller: priceprod,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Product Price";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Product Price",
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Image
                  TextFormField(
                    controller: imagprod,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Image URL";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Image URL",
                      prefixIcon: Icon(Icons.image),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                   
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (productkey.currentState!.validate()) {
                        
                        addproduct();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Success"),
                              content: Text("Product Added Successfully"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );

                        nameprod.clear();
                        priceprod.clear();
                        imagprod.clear();

                      }
                    },
                    child: Text(
                      "Add Product",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                
                   
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}