import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
      body: ListView(children: [
        Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text('Password Change',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
            child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Enter Old Password',
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
            child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Enter New Password',
                    ),
                  ),
          ),
          Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MaterialButton(
                          minWidth: 150.0,
                          height:50.0,
                          onPressed: () {},
                          color: Theme.of(context).accentColor,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Save', style:TextStyle(fontSize:20.0)),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MaterialButton(
                          minWidth: 150.0,
                          height:50.0,
                          onPressed: () {},
                          color: Theme.of(context).accentColor,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Cancle', style:TextStyle(fontSize:20.0)),
                          )),
                    ),
                  ],
                )
      ],)
    );
  }
}