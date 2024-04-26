import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherapp/weather_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Weatherscreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icon/cloud.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
