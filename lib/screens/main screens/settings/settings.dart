import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:10.0, top:20.0),
            child: Text('Change Avatar', style: TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold)),
          ),
          Container(
            height: 120.0,
            width: 120.0,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).accentColor, width: 5),
                image: DecorationImage(
                  image: AssetImage('assets/avatar/avatar1.png'),
                  fit: BoxFit.contain,
                )),
            child: Align(
              alignment: Alignment.lerp(
                  Alignment.bottomCenter, Alignment.bottomRight, 0.25),
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
           Padding(
            padding: const EdgeInsets.only(left:10.0, top:20.0),
            child: Text('Change Language', style: TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold)),
          ),
           Padding(
            padding: const EdgeInsets.only(left:10.0, top:20.0),
            child: Text('Change Country', style: TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold)),
          ),
           Padding(
            padding: const EdgeInsets.only(left:10.0, top:20.0),
            child: Text('Change Password', style: TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
