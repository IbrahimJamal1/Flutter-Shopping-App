import 'package:ecommerce/home.dart';
import 'package:ecommerce/login.dart';
import 'package:ecommerce/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List product = [
  {
    "imag": "https://m.media-amazon.com/images/I/71TPda7cwUL._AC_SX679_.jpg",
    "name": "HP Pavilion 15",
    "price": "1400"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/81bc8ma3nGL._AC_SX679_.jpg",
    "name": "MacBook Air M3",
    "price": "1099"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/61f7A9QvS6L._AC_SX679_.jpg",
    "name": "Dell XPS 13",
    "price": "1250"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71W85RovSXL._AC_SX679_.jpg",
    "name": "Lenovo Yoga 7i",
    "price": "850"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71f5Eu5lJSL._AC_SX679_.jpg",
    "name": "ASUS ROG Zephyrus G14",
    "price": "1650"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71-6Rz1-3NL._AC_SX679_.jpg",
    "name": "Acer Swift Go 14",
    "price": "799"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/81X8N6E5fBL._AC_SX679_.jpg",
    "name": "Microsoft Surface Laptop 6",
    "price": "1100"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71D-P3kP9GL._AC_SX679_.jpg",
    "name": "Razer Blade 16",
    "price": "2999"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71N6f3i7zXL._AC_SX679_.jpg",
    "name": "MSI Stealth 14 Studio",
    "price": "1500"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/61NfT-jV0CL._AC_SX679_.jpg",
    "name": "Samsung Galaxy Book4 Pro",
    "price": "1450"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71YvY-6v7NL._AC_SX679_.jpg",
    "name": "HP Envy x360",
    "price": "950"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/61U0aH6v7JL._AC_SX679_.jpg",
    "name": "Dell Alienware m16",
    "price": "2100"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71-LzP4yFLL._AC_SX679_.jpg",
    "name": "LG Gram 17",
    "price": "1350"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71M-r6yV0HL._AC_SX679_.jpg",
    "name": "Gigabyte AERO 14 OLED",
    "price": "1700"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/81h9i-7vRFL._AC_SX679_.jpg",
    "name": "Lenovo ThinkPad X1 Carbon",
    "price": "1850"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71-6Rz1-3NL._AC_SX679_.jpg",
    "name": "Acer Predator Helios Neo",
    "price": "1150"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/61gK6yV0HL._AC_SX679_.jpg",
    "name": "MacBook Pro 14 M3 Pro",
    "price": "1999"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71vFKBp6YPL._AC_SX679_.jpg",
    "name": "ASUS Zenbook 14 OLED",
    "price": "1050"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/81m-vV6yVHL._AC_SX679_.jpg",
    "name": "Framework Laptop 13",
    "price": "1049"
  },
  {
    "imag": "https://m.media-amazon.com/images/I/71-LzP4yFLL._AC_SX679_.jpg",
    "name": "Victus by HP 16",
    "price": "920"
  }
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
        "main": (context) => intropage(),
        "log": (context) => Login(),
        "regis": (context) => Register(),
        "home": (context) => Home(),
      },

      home: intropage(),
    );
  }
}

class intropage extends StatelessWidget {
  const intropage({super.key});

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
          color: Colors.black.withOpacity(0.4), 

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