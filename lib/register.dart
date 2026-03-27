import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
  
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          backgroundColor: Colors.lightBlueAccent,
        ),

        body: Form( // ✅ فورم واحدة
          key: formkey,
          child: Column(
            spacing: 25,
            children: [

              Container(
                child: Text(""),
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val!.isEmpty ) {
                      return "Required";
                    }
                    if (val.length < 3) {
                      return "Name must be at least 3 characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Name",
                    suffixIcon: Icon(Icons.people),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Required";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                      return "Enter numbers only";
                    }
                    if (val.length != 11) {
                      return "Phone must be 11 digits";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "phon",
                    suffixIcon: Icon(Icons.phone),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: mail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val!.isEmpty) {
                      if (val.contains("@")) {
                        return "Required @ ";
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Emain",
                    suffixIcon: Icon(Icons.mail),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: birth,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Birth Day",
                    suffixIcon: Icon(Icons.date_range),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: pass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val!.isEmpty ) {
                      return "Required ";
                    }
                    if (val.length < 6) {
                      return "At least 6 characters";
                    }
                    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(val)) {
                      return "Must contain letters & numbers";
                    }
                    return null;
                  },
                  
                  decoration: InputDecoration(
                    hintText: "password",
                    suffixIcon: Icon(Icons.password),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(30),
                child: Row(
                  spacing: 30,
                  children: [

                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            
                          }

                        },
                        color: Colors.blue,
                        child: Text("save",
                            style: TextStyle(
                                color: Colors.white, fontSize: 25)),
                      ),
                    ),

                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          name.clear();
                          phone.clear();
                          mail.clear();
                          birth.clear();
                          pass.clear();
                        },
                        color: Colors.red,
                        child: Text("reset",
                            style: TextStyle(
                                color: Colors.white, fontSize: 30)),
                      ),
                    ),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

