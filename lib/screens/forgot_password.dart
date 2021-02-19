import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  bool val = true;
  //----------------------- Text Controllers------------------//
  var emailtextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailtextController.dispose();
    super.dispose();
  }


  _showDialog(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          );
        });
  }

  void finished(){
    setState(() {
          Navigator.pop(context);
        });
  }

  void _loginInWithEmailAndPassword() async {
    try {
      _auth.sendPasswordResetEmail(email: emailtextController.text);
     Fluttertoast.showToast(
        msg: "Password Change request sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
    );
    emailtextController.text='';
    Timer(Duration(seconds: 7), finished);
    } catch (e) {
      print('Error is: $e');
      emailtextController.text = "";
      _showDialog('LogIn Error', 'Please check your email and password.');
    }
  }

  //------------------------------Form Feilds---------------------//

  Widget formFields(String text, IconData icon) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 10.0, right: 30.0, left: 30.0),
        child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains("Cannot be Empty")) {
                setState(() {
                  errors.remove("Cannot be Empty");
                });
              }      
             if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value) &&
                    errors.contains("Invalid Email Id.")) {
                  setState(() {
                    errors.remove("Invalid Email Id.");
                  });
              }
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains("Cannot be Empty")) {
                setState(() {
                  errors.add("Cannot be Empty");
                });
                return null;
              }
                if (!(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) &&
                    !errors.contains("Invalid Email Id.")) {
                  setState(() {
                    errors.add("Invalid Email Id.");
                  });
                  return null;
                }
              return null;
            },
            controller: emailtextController,
            style: TextStyle(decoration: TextDecoration.none),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white,
              ),
              hintText: text,
              hintStyle: TextStyle(color: Colors.white60),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(width: 2.0, color: Colors.white)),
            )));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.99, 0.5),
              colors: [
                Colors.blue,
                Colors.lightBlueAccent,
              ],
              tileMode: TileMode.repeated),
        ),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    letterSpacing: .5,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Langar',
                  ),
                ),
              ],
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  formFields('Email', Icons.email),
                  ErrorLine(
                    errors: errors,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 70,
                      child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate() &&
                                errors.isEmpty) {
                              _loginInWithEmailAndPassword();
                            }
                          },
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 3.0),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Send Request',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: 'Pacifico'),
                            ),
                          )),
                    ),
                  ),
                ],
              )),
        ]),
      ),
    ));
  }
}

//------------------------Error List----------------------//

class ErrorLine extends StatelessWidget {
  const ErrorLine({
    Key key,
    @required this.errors,
  }) : super(key: key);
  final List<String> errors;

  Widget errorLine(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
      child: Expanded(
        child: Row(
          children: [
            Icon(
              Icons.error,
              size: 18.0,
              color: Colors.red[900],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.red[900]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          List.generate(errors.length, (index) => errorLine(errors[index])),
    );
  }
}
