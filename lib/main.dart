import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/registration.dart';
import 'screens/signup.dart';
import 'screens/login.dart';
import 'screens/main screens/home.dart';
import 'screens/main screens/category/category_page.dart';
import 'screens/main screens/article_page.dart';
import 'screens/confirmation_page.dart';
import 'screens/main screens/nav.dart';

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
        '/nav': (context) => NavBar(),
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