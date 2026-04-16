import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController passw = TextEditingController();

  bool remb = false;
  bool obscure = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),

      appBar: AppBar(
        title: Text("MegaDevices"),
        backgroundColor: Color(0xFF0D47A1),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),

            Text(
              "Let's get started",
              style: TextStyle(
                fontSize: 28,
                color: Color(0xFF0D47A1),
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30),

            
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon:
                      Icon(Icons.email, color: Color(0xFF0D47A1)),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: passw,
                obscureText: obscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon:
                      Icon(Icons.lock, color: Color(0xFF0D47A1)),
                  hintText: "Password",

                  suffixIcon: IconButton(
                    icon: Icon(obscure
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            CheckboxListTile(
              value: remb,
              onChanged: (val) {
                setState(() {
                  remb = val!;
                });
              },
              title: Text("Remember me"),
            ),

            SizedBox(height: 10),

            MaterialButton(
              minWidth: 200,
              height: 50,
              color: Color(0xFF1976D2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text("Login",
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (email.text == "ibrahim@gmail.com" &&
                    passw.text == "123") {

                  name = "Ibrahim Gamal";
                  e_mail = email.text;
                  image = null; 

                  Navigator.of(context)
                      .pushReplacementNamed("home");

                } else {
                  showError(context);
                }
              },
            ),

            SizedBox(height: 15),

           
            MaterialButton(
              minWidth: 200,
              height: 50,
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text("Reset",
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                email.clear();
                passw.clear();
              },
            ),
          ],
        ),
      ),
    );
  }

  void showError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error",
              style: TextStyle(color: Colors.red)),
          content: Text("Email or Password not correct"),
        );
      },
    );
  }
}