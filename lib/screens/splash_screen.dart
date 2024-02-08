import 'dart:async';

import 'package:first_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  // Yaha pr rok rhe timer lga k 2 second k liye;
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Image.asset(
            "assets/images/splash_pic.jpg",
            fit: BoxFit.cover,
            width: width * .9,
            height: height * .5,
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Text(
            "TOP HEADLINES",
            style: GoogleFonts.anton(
                fontSize: 20, letterSpacing: .6, color: Colors.grey.shade700),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          const SpinKitCircle(
            color: Colors.blue,
            size: 40,
          )
        ],
      ),
    );
  }
}
