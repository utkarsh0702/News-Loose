import 'package:flutter/material.dart';
import 'search_page.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  DateTime today = DateTime.now();
  DateTime fromselectedDate = DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day + 1);
  DateTime toselectedDate = DateTime.now();
  String query = "";
  String currentCon = 'All';
  List<String> sources = [
    'All',
    'ABC News',
    'BBC News',
    'Business Insider',
    'CNN',
    'Buzzfeed',
    'Fox',
    'ESPN'
  ];

  _selectDate(BuildContext context, bool date) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date ? fromselectedDate : toselectedDate, 
      firstDate: DateTime(today.year, today.month - 1, today.day + 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != fromselectedDate && date == true)
      setState(() {
        fromselectedDate = picked;
      });
    else if (picked != null && picked != toselectedDate && date == false)
      setState(() {
        toselectedDate = picked;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: ListView(
            children: [
              //------------------------------ Search Bar ----------------------------//
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onSubmitted: (value) {
                    query = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: 'Search',
                  ),
                ),
              ),
              //--------------------Date Picking From-----------------------//
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Row(children: [
                        Icon(Icons.calendar_today),
                        Text("Date From : ",
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'Pacifico')),
                        SizedBox(width: 10.0),
                        Text(
                          "${fromselectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico'),
                        ),
                      ]),
                    ),
                    RaisedButton(
                      onPressed: () => _selectDate(context, true),
                      child: Text(
                        'Select date',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              ),
              //--------------------Date Picking To-----------------------//
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(children: [
                        Icon(Icons.calendar_today),
                        Text("Date To : ",
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'Pacifico')),
                        SizedBox(width: 10.0),
                        Text(
                          "${toselectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico'),
                        ),
                      ]),
                    ),
                    RaisedButton(
                      onPressed: () => _selectDate(context, false),
                      child: Text(
                        'Select date',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              ),
              //------------------------ Source DropDown Menu----------------------//
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Icon(Icons.source),
                    Text("Sources : ",
                        style: TextStyle(fontSize: 20.0, fontFamily: 'Pacifico')),
                    SizedBox(width: 10.0),
                    Container(
                      padding: EdgeInsets.only(left: 7.0, right: 2.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton(
                        iconEnabledColor: Colors.white,
                        dropdownColor: Theme.of(context).primaryColor,
                        elevation: 10,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            textBaseline: TextBaseline.alphabetic),
                        items: sources.map((con) {
                          return DropdownMenuItem(
                            value: con,
                            child: Center(
                              child: Text(
                                con,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Langar',
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newCon) {
                          setState(() {
                            this.currentCon = newCon;
                          });
                        },
                        value: currentCon,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 20.0, left: 40.0, right: 40.0),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(
                                    query : query,
                                    fromdate : "${fromselectedDate.toLocal()}".split(' ')[0],
                                    todate : "${toselectedDate.toLocal()}".split(' ')[0],
                                    source : currentCon.toLowerCase().replaceAll(" ", "-"),
                                  )));
                    },
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).accentColor, width: 3.0),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Search',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'Pacifico'),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}