import 'package:ecommerce/cart.dart';
import 'package:ecommerce/home.dart';
import 'package:ecommerce/login.dart';
import 'package:ecommerce/phone.dart';
import 'package:ecommerce/register.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/providerapp.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

List Prodects = [
  {
    "imag": "images/image_1.jpg",
    "name": "HP Pavilion 15",
    "price": "1400"
  },
  {
    "imag": "images/image_2.jpg",
    "name": "MacBook Air M3",
    "price": "1099"
  },
  {
    "imag": "images/image_3.jpg",
    "name": "Dell XPS 13",
    "price": "1250"
  },
  {
    "imag": "images/image_4.jpg",
    "name": "Lenovo Yoga 7i",
    "price": "850"
  },
  {
    "imag": "images/image_5.jpg",
    "name": "ASUS ROG Zephyrus G14",
    "price": "1650"
  },
  
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: Color(0xFF0D47A1),
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      routes: {
        "main": (context) => Intropage(),
        "log": (context) => Login(),
        "regis": (context) => Register(),
        "home": (context) => Home(),
        "cart":(context) => Mycart(),
        "phone":(context) => Phone(),
      },

      home: Home(),
      
    );
  }
}

class Intropage extends StatelessWidget {
  const Intropage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome To App"),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to our store! We offer high-quality devices at great prices.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: Colors.black, blurRadius: 10),
                  ],
                ),
              ),

              SizedBox(height: 40),

              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      onPressed: () {
                        Navigator.of(context).pushNamed("regis");
                      },
                      color: Color(0xFF1976D2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      onPressed: () {
                        Navigator.of(context).pushNamed("log");
                      },
                      color: Color(0xFF1976D2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}