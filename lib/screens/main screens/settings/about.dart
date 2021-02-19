import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top:50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  ),
  //------------------------------------TITLE-------------------------------//
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'NEWS ',
                      style:TextStyle(
                        fontSize: 30.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'LOOSE',
                      style:TextStyle(
                        fontSize: 30.0,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  ],
                ),

  //--------------------------------------Version------------------------------//
                SizedBox(height: 10.0,),
                Text(
                  'VERSION: 0.0.1',
                  style:TextStyle(
                    fontSize: 15.0,
                  ),
                  ),

  //-----------------------------------Copyright----------------------------------//
                SizedBox(height: 10.0,),
                Text(
                  "\u00a9 2021, Utkarsh Mishra",
                  style:TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Divider(
                    thickness: 2.0,
                    indent: 4.0
                  ),
                ),
  //-------------------------------------- Short Description ----------------------------//
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "A Simple News App built with Flutter with uses News API to display news on the Home Page. "
                    "News categories ranges from tech to entertainment. You can choose news category displayed on "
                    "category page. App is providing a smooth and amazing design with gestures effect and smooth "
                    "experience with android platform.",
                    style:TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}