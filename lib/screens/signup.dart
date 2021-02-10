import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Shared Preferences
  SharedPreferences localStorage;

  // ignore: non_constant_identifier_names
  void change_value() async {
    localStorage = await SharedPreferences.getInstance();
    await localStorage.setBool('login', false);
  }

  //----------------------- Text Controllers------------------//
  var emailtextController = TextEditingController();
  var passtextController = TextEditingController();
  var nametextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passtextController.dispose();
    emailtextController.dispose();
    super.dispose();
  }

//--------------------------- Form Feilds------------------------------------//
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  bool values = true;

  //------------------------- firestore --------------------------------//
  final CollectionReference userCollection = Firestore.instance.collection('User Data');

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

  Future updateUserData(String name, String uid, String email) async {
    return await userCollection.document(uid).setData({
      'Email Id': email,
      'Name': name,
      'Image Number': 0,
      'Country': 'in',
    });
  }

  void _register() async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: emailtextController.text,
        password: passtextController.text,
      ))
          .user;

      if (user != null) {
        updateUserData(nametextController.text, user.uid, emailtextController.text);
        change_value();
        Navigator.pushNamed(context, '/confirm');
      }
    } catch (e) {
      print('Error is: $e');
      nametextController.text = "";
      emailtextController.text = "";
      passtextController.text = "";
      _showDialog('Error',
          'Facing problem with creating the account. Account Already exists..');
    }
  }

  Widget formFields(String text, IconData icon, int val) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, right: 30.0, left: 30.0),
      child: TextFormField(
        keyboardType: val == 0
            ? TextInputType.name
            : (val == 1
                ? TextInputType.emailAddress
                : TextInputType.visiblePassword),
        onChanged: (value) {
          if (value.isNotEmpty &&
              errors.contains("Required.. Cannot be Empty")) {
            setState(() {
              errors.remove("Required.. Cannot be Empty");
            });
          }
          if (val == 0) {
            if (value.length >= 3 &&
                errors.contains("Should have atleast 3 characters.")) {
              setState(() {
                errors.remove("Should have atleast 3 characters.");
              });
            }
          }
          if (val == 2) {
            if (value.length >= 6 &&
                errors.contains("Password should have atleast 6 characters.")) {
              setState(() {
                errors.remove("Password should have atleast 6 characters.");
              });
            }
          }
          if (val == 1) {
            if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value) &&
                errors.contains("Please write a valid email id.")) {
              setState(() {
                errors.remove("Please write a valid email id.");
              });
            }
          }
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains("Required.. Cannot be Empty")) {
            setState(() {
              errors.add("Required.. Cannot be Empty");
            });
            return null;
          }
          if (val == 0) {
            if (value.length < 3 &&
                !errors.contains("Should have atleast 3 characters.")) {
              setState(() {
                errors.add("Should have atleast 3 characters.");
              });
              return null;
            }
          }
          if (val == 2) {
            if (value.length < 6 &&
                !errors
                    .contains("Password should have atleast 6 characters.")) {
              setState(() {
                errors.add("Password should have atleast 6 characters.");
              });
              return null;
            }
          }
          if (val == 1) {
            if (!(RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) &&
                !errors.contains("Please write a valid email id.")) {
              setState(() {
                errors.add("Please write a valid email id.");
              });
              return null;
            }
          }
          return null;
        },
        obscureText: (val == 2 && values == true) ? true : false,
        controller: val == 0
            ? nametextController
            : (val == 1 ? emailtextController : passtextController),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: text,
          hintStyle: TextStyle(color: Colors.white60),
          suffixIcon: val == 2
              ? IconButton(
                  icon: values == true
                      ? Icon(
                          LineAwesomeIcons.eye,
                          color: Colors.white,
                        )
                      : Icon(
                          LineAwesomeIcons.eye_slash,
                          color: Colors.white,
                        ),
                  onPressed: () {
                    setState(() {
                      values = !values;
                    });
                  })
              : Icon(null),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        style: TextStyle(decoration: TextDecoration.none),
      ),
    );
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: .5,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Langar',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Register Account',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Pacifico',
                    color: Colors.white),
              ),
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  formFields(
                    'Name',
                    Icons.person,
                    0,
                  ),
                  formFields(
                    'Email',
                    Icons.email,
                    1,
                  ),
                  formFields(
                    'Password',
                    Icons.lock,
                    2,
                  ),
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
                              _register();
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
                              'Create Account',
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
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
            child: Expanded(
                child: Text(
              'By clicking you confirm that you agree with our Terms and Conditions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
          )
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
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.red),
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
