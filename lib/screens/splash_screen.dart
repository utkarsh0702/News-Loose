import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool newuser;
  SharedPreferences localStorage;
    // ignore: non_constant_identifier_names
  void check_if_already_login() async{
    localStorage = await SharedPreferences.getInstance();
    newuser = (localStorage.getBool('login') ?? true);
    if(newuser == false){
      Navigator.pushNamed(context, '/nav');
    }
    else{
      Navigator.pushNamed(context, '/reg');
    }
  }

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 7), finished);
  }

  void finished(){
    _checkInternetConnectivity();
  }

   _checkInternetConnectivity() async{
      try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            check_if_already_login();
          }
        } on SocketException catch (_) {
          _showDialog('No Internet', 'You are not connected to network.');
		  Timer(Duration(seconds: 5), finished);
        }
    }

  _showDialog(title, text){
    showDialog(
      context: context,
      builder: (context){
        Future.delayed(Duration(seconds: 5),(){
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('Ok'),
              )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
            height: 100.0,
            width: 100.0,
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).accentColor, width: 1),
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                )),
                ),
              // Image.asset('assets/images/logo.jpg'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NEWS ',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                    ),
                    Text(
                    'LOOSE',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                    )
                ],
              ),
            ],
          ),
        ),
    );
  }
}