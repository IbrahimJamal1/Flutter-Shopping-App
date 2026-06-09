import 'package:ecommerce/adminprod.dart';
import 'package:ecommerce/cart.dart';
import 'package:ecommerce/home.dart';
import 'package:ecommerce/login.dart';
import 'package:ecommerce/phone.dart';
import 'package:ecommerce/register.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/providerapp.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
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

// List laptopDev = [
//   {
//     "imag": "images/lapimage/image_1.jpg",
//     "name": "HP Pavilion 15",
//     "price": "1400"
//   },
//   {
//     "imag": "images/lapimage/image_2.jpg",
//     "name": "MacBook Air M3",
//     "price": "1099"
//   },
//   {
//     "imag": "images/lapimage/image_3.jpg",
//     "name": "Dell XPS 13",
//     "price": "1250"
//   },
//   {
//     "imag": "images/lapimage/image_4.jpg",
//     "name": "Lenovo Yoga 7i",
//     "price": "850"
//   },
//   {
//     "imag": "images/lapimage/image_5.jpg",
//     "name": "ASUS ROG Zephyrus G14",
//     "price": "1650"
//   },
  
// ];

// List phoneDev = [
//   {
//     "imag": "images/phone/imag_1.jpg",
//     "name": "iPhone 15",
//     "price": "999"
//   },
//   {
//     "imag": "images/phone/imag_2.jpg",
//     "name": "Samsung Galaxy S24",
//     "price": "899"
//   },
//   {
//     "imag": "images/phone/imag_3.jpg",
//     "name": "Google Pixel 8",
//     "price": "799"
//   },
//   {
//     "imag": "images/phone/imag_4.jpg",
//     "name": "OnePlus 12",
//     "price": "749"
//   },
//   {
//     "imag": "images/phone/imag_5.jpg",
//     "name": "Xiaomi 14",
//     "price": "699"
//   },
//   {
//   "imag": "images/phone/imag_6.jpg",
//   "name": "Xiaomi 14",
//   "price": "4758"
//   },
//   {
//     "imag": "images/phone/imag_7.jpg",
//     "name": "Xiaomi 14",
//     "price": "8000"
//   }

// ];

// List tvDev = [
//   {
//     "imag": "images/tvimage/image_1.jpg",
//     "name": "Samsung 55 Smart TV",
//     "price": "600"
//   },
//   {
//     "imag": "images/tvimage/image_2.jpg",
//     "name": "LG OLED 65",
//     "price": "1200"
//   },
//   {
//     "imag": "images/tvimage/image_3.jpg",
//     "name": "Sony Bravia 50",
//     "price": "750"
//   },
//   {
//     "imag": "images/tvimage/image_4.jpg",
//     "name": "TCL 4K Smart TV",
//     "price": "450"
//   },
//   {
//     "imag": "images/tvimage/image_5.jpg",
//     "name": "Hisense 55 Inch",
//     "price": "500"
//   },
//   {
//     "imag": "images/tvimage/image_6.jpg",
//     "name": "Xiaomi Mi TV 4A",
//     "price": "400"
//   },
//   {
//     "imag": "images/tvimage/image_7.jpg",
//     "name": "Philips Ambilight 58",
//     "price": "800"
//   }
// ];

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
      
      home: Home(),

      routes: {
        "main": (context) => Intropage(),
        "log": (context) => Login(),
        "regis": (context) => Register(),
        "home": (context) => Home(),
        "cart":(context) => Mycart(),
        "phone":(context) => Phone(),
        "admin":(context) => Admin(),
      },

    );
  }
}
class Intropage extends StatelessWidget {
  const Intropage({super.key});
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushReplacementNamed("home");
        },
        backgroundColor: Colors.blue,
        child: Text("SKIP",style: TextStyle(color: Colors.white),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                
                const Text(
                  "Welcome to our Store",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "High quality devices at the best prices",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 50),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("regis");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("log");
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 40),


              ],
            ),
          ),
        ),
      ),
    );
  }
}