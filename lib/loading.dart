import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class Loadingpage extends StatefulWidget {
  const Loadingpage({super.key});

  @override
  State<Loadingpage> createState() => _LoadingpageState();
}

String loadstr = "";

class _LoadingpageState extends State<Loadingpage> {
  String loadingText = "Loading";
  int dots = 0;
  double progress = 0;
  Random random = Random();

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(milliseconds: 350), (timer) {
      setState(() {
        dots = (dots + 1) % 4;
        loadingText = "Loading${"." * dots}";

        if (progress < 0.95) {
          progress += random.nextDouble() * 0.05;
        } else {
          timer.cancel();
          if (!mounted) return;
          Navigator.of(context).pushReplacementNamed("home");
        }
        progress.clamp(0.0, 1.0);
        loadstr = (progress * 100).toStringAsFixed(0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [Color(0xFF5DB4FF), Color(0xFF092CD9)],
          ),
        ),

        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    width: 180,
                    height: 180,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("images/loadimage.png"),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  Text(
                    loadingText,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "$loadstr % ",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
              margin: EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 22,
                backgroundColor: Colors.white24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
