import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  Future<void> register() async {
    setState(() => loading = true);

    try {
      //  Create user in Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: mail.text.trim(),
            password: pass.text.trim(),
          );

      String uid = userCredential.user!.uid;

      // Save extra data in Firestore
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "name": name.text.trim(),
        "phone": phone.text.trim(),
        "email": mail.text.trim(),
        "birth": birth.text.trim(),
        "uid": uid,
      });

      //  Success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created Successfully")),
      );

      //  Navigate
      Navigator.pushReplacementNamed(context, "login");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
    }

    setState(() => loading = false);
  }

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  InputDecoration buildInput(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: name,
                        decoration: buildInput("Name", Icons.person),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Required";
                          }
                          if (val.length < 3) {
                            return "Min 3 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration: buildInput("Phone", Icons.phone),
                        validator: (val) {
                          if (val == null || val.isEmpty) return "Required";
                          if (val.length != 11) return "Must be 11 digits";
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: mail,
                        decoration: buildInput("Email", Icons.email),
                        validator: (val) {
                          if (val == null || val.isEmpty) return "Required";
                          if (!val.contains("@")) return "Invalid email";
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: birth,
                        decoration: buildInput("Birth Date", Icons.date_range),
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: pass,
                        obscureText: true,
                        decoration: buildInput("Password", Icons.lock),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Required";
                          }
                          if (val.length < 6) {
                            return "Min 6 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              await register();
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                .pushReplacementNamed("log");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Register"),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          name.clear();
                          phone.clear();
                          mail.clear();
                          birth.clear();
                          pass.clear();
                        },
                        child: const Text("Reset Form"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
