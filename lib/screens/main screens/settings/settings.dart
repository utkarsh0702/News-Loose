import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:NewsLoose/helper/lookup.dart';
import 'change_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool change = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  TextEditingController _nameController = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    assignValues();
  }

  assignValues() async {
    user = await auth.currentUser();
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  updateImage(int number) async {
    Firestore.instance
        .collection('User Data')
        .document(user.uid)
        .updateData({'Image Number': number});
  }

  updateName(String name) async {
    Firestore.instance
        .collection('User Data')
        .document(user.uid)
        .updateData({'Name': name});
  }

  updateCountry(String country) async {
    Firestore.instance
        .collection('User Data')
        .document(user.uid)
        .updateData({'Country': country});
  }

  //--------------------------Horizontal Sliding Country List----------------------//
  Widget countryFlags(String flagName, String countryName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          updateCountry(flagName.toLowerCase());
          Toast.show("Country Changes to $countryName", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        },
        child: Card(
          color: Colors.transparent,
          elevation: 10.0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2.0)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Container(
                    width: 100.0,
                    height: 50.0,
                    child: Flag(
                      flagName,
                      height: 50.0,
                      width: 100.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(countryName, style: TextStyle(fontFamily: 'Langar'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeAvatar(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      updateImage(result);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: _loading
            ? Center(
              child: Container(
                child: CircularProgressIndicator()
                ))
            : StreamBuilder(
                stream: Firestore.instance
                    .collection('User Data')
                    .document(user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                  return Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Text('Change Avatar',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          height: 120.0,
                          width: 120.0,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).accentColor, width: 5),
                              image: DecorationImage(
                                image: AssetImage(
                                    imageLookUp(snapshot.data['Image Number'])),
                                fit: BoxFit.contain,
                              )),
                          child: Align(
                            alignment: Alignment.lerp(Alignment.bottomCenter,
                                Alignment.bottomRight, 0.25),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _awaitReturnValueFromSecondScreen(context);
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.yellow[900],
                                ),
                                child: Icon(
                                  LineAwesomeIcons.pencil,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Text('Change Name',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        change
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 30.0, right: 30.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        hintText: 'Enter Name',
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: MaterialButton(
                                              minWidth: 100.0,
                                              onPressed: () {
                                                setState(() {
                                                  updateName(
                                                      _nameController.text);
                                                  change = false;
                                                });
                                              },
                                              color:
                                                  Theme.of(context).accentColor,
                                              elevation: 20,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              child: Text('Save')),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: MaterialButton(
                                              minWidth: 100.0,
                                              onPressed: () {
                                                setState(() {
                                                  change = false;
                                                });
                                              },
                                              color:
                                                  Theme.of(context).accentColor,
                                              elevation: 20,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              child: Text('Cancle')),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 30.0, top: 10.0),
                                child: Row(children: [
                                  Text(snapshot.data['Name'],
                                      style: TextStyle(fontSize: 20.0)),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            change = true;
                                          });
                                        },
                                        color: Theme.of(context).accentColor,
                                        elevation: 20,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text('Change')),
                                  )
                                ]),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Text('Change Country',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            // color: Colors.grey[300],
                          ),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: <Widget>[
                                countryFlags('IN', 'India'),
                                countryFlags('US', 'United States of America'),
                                countryFlags('GB', 'United Kingdom'),
                                countryFlags('CH', 'Switzerland'),
                                countryFlags('NZ', 'New Zealand'),
                                countryFlags('BR', 'Brazil'),
                                countryFlags('AU', 'Australia'),
                              ])),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Text('Change Password',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 70,
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/changePassword');
                                },
                                color: Theme.of(context).accentColor,
                                splashColor: Theme.of(context).primaryColor,
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Change Password',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  );}
                  return Center(child: CircularProgressIndicator(),);
                }));
  }
}
