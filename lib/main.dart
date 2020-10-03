import 'package:flutter/material.dart';
import 'package:NewsLoose/screens/registration.dart';
import 'package:NewsLoose/screens/signup.dart';
import 'package:NewsLoose/screens/login.dart';

void main(){
  runApp(myApp());
}

// ignore: camel_case_types
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signup': (context) => SignUp(),
        '/login': (context) => LogIn(),
      },
      title: 'News Loose',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[400],
        accentColor: Colors.yellow[900],
      ),
      home: RegPage(),
    );
  }
}