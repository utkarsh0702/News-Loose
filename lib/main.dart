import 'package:flutter/material.dart';
import 'package:NewsLoose/screens/splash_screen.dart';
import 'package:NewsLoose/screens/registration.dart';
import 'package:NewsLoose/screens/signup.dart';
import 'package:NewsLoose/screens/login.dart';
import 'package:NewsLoose/screens/main screens/home.dart';
import 'package:NewsLoose/screens/main screens/category_page.dart';
import 'package:NewsLoose/screens/main screens/article_page.dart';
import 'package:NewsLoose/screens/confirmation_page.dart';

void main(){
  runApp(myApp());
}

// ignore: camel_case_types
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/reg': (context) => RegPage(),
        '/signup': (context) => SignUp(),
        '/login': (context) => LogIn(),
        '/confirm': (context) => Confirm(),
        '/home': (context) => HomePage(),
        '/category': (context) => CategoryPage(),
        '/article': (context) => ArticlePage(),
      },
      title: 'News Loose',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[400],
        accentColor: Colors.yellow[900],
      ),
      home: Splash(),
    );
  }
}