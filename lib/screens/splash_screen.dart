import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

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
            Navigator.pushNamed(context, '/home');
          }
        } on SocketException catch (_) {
          _showDialog('No Internet', 'You are not connected to network.');
        }
    }

  _showDialog(title, text){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            FlatButton(
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
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'NEWS',
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
            )
          ),
        ),
    );
  }
}