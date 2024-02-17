import 'package:first_app/screens/category_screen.dart';
import 'package:first_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'screens/check_scroll.dart';
import 'screens/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Material App',
      home: SplashScreenfsf(),
      debugShowCheckedModeBanner: false,
    );
  }
}
