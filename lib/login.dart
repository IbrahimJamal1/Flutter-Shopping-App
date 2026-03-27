import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController passw = TextEditingController();

  bool remb = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),

      appBar: AppBar(
        title: Text("MegaDevices"),
        backgroundColor: Color(0xFF0D47A1),
        elevation: 0,
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
                  prefixIcon: Icon(Icons.email, color: Color(0xFF0D47A1)),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFF0D47A1), width: 2),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: passw,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF0D47A1)),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFF0D47A1), width: 2),
                  ),
                ),
              ),
            ),

            CheckboxListTile(
              activeColor: Color(0xFF0D47A1),
              title: Text(
                "Remember me",
                style: TextStyle(color: Color(0xFF212121)),
              ),
              value: remb,
              onChanged: (val) {
                setState(() {
                  remb = val!;
                });
              },
            ),

            SizedBox(height: 10),

            MaterialButton(
              minWidth: 200,
              height: 50,
              onPressed: () {
                if (email.text == "") {
                  if (passw.text == "") {
                    Navigator.of(context).pushNamed("home");
                  } else {
                    showError(context);
                  }
                } else {
                  showError(context);
                }
              },
              color: Color(0xFF1976D2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),

            SizedBox(height: 15),

            MaterialButton(
              minWidth: 200,
              height: 50,
              onPressed: () {
                email.clear();
                passw.clear();
              },
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Reset",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),

            SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("regis");
              },
              child: Text(
                "Forgot password?",
                style: TextStyle(color: Color(0xFF0D47A1)),
              ),
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
          backgroundColor: Colors.white,
          title: Text(
            "Error",
            style: TextStyle(color: Colors.red),
          ),
          content: Text("Password or Email is not correct"),
          icon: Icon(Icons.error, color: Colors.red),
        );
      },
    );
  }
}