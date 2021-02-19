import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:toast/toast.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //----------------------- Text Controllers------------------//
  var emailtextController = TextEditingController();
  var passtextController = TextEditingController();
  var newtextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    passtextController.dispose();
    emailtextController.dispose();
    newtextController.dispose();
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
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          );
        });
  }

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  bool values = true;

  Widget formFields(String text, IconData icon, int val) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, right: 30.0, left: 30.0),
      child: TextFormField(
        keyboardType: val == 1
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        onChanged: (value) {
          if (value.isNotEmpty &&
              errors.contains("Required.. Cannot be Empty")) {
            setState(() {
              errors.remove("Required.. Cannot be Empty");
            });
          }
          if (val == 2 || val == 0) {
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
          if (val == 2 || val == 0) {
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
        obscureText: ((val == 2 || val == 0) && values == true) ? true : false,
        controller: val == 0
            ? newtextController
            : (val == 1 ? emailtextController : passtextController),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
          ),
          hintText: text,
          suffixIcon: (val == 2 || val == 0)
              ? IconButton(
                  icon: values == true
                      ? Icon(
                          LineAwesomeIcons.eye,
                        )
                      : Icon(
                          LineAwesomeIcons.eye_slash,
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
    Future<void> _change() async {
      try {
        final FirebaseUser user = await auth.currentUser();
        AuthCredential credential = EmailAuthProvider.getCredential(
            email: emailtextController.text, password: passtextController.text);
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newtextController.text);
        Toast.show("Password Updated Sucessfully", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        emailtextController.text='';
        passtextController.text='';
        newtextController.text='';
      } catch (e) {
        print("Error: $e");
        _showDialog('Error', 'Facing problem with updating password..');
        emailtextController.text='';
        passtextController.text='';
        newtextController.text='';
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              Text(
                'Settings',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(
                flex: 2,
              )
            ],
          ),
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Text('Password Change',
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
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
                    formFields(
                      'New Password',
                      Icons.lock,
                      0,
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
                                _change();
                              }
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 3.0),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Update Password',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 25.0,
                                    fontFamily: 'Pacifico'),
                              ),
                            )),
                      ),
                    ),
                  ],
                )),
          ],
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
