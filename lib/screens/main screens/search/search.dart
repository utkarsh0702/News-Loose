import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DateTime selectedDate = DateTime(2000, 1, 1);
  String query = "";
  var currentCon = 'All';
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

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  //--------------------Available sort by btn values----------------------------//
  String sortVal = "";
  bool isbt1 = false;
  bool isbt2 = false;
  bool isbt3 = false;

  Widget availableSort(String text, {String btn}) {
    bool isSelected = false;
    if (btn == "bt1") {
      isSelected = isbt1;
    } else if (btn == "bt2") {
      isSelected = isbt2;
    } else if (btn == "bt3") {
      isSelected = isbt3;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: MaterialButton(
            minWidth: 1.0,
            color: isSelected ? Theme.of(context).accentColor : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                    style: !isSelected ? BorderStyle.solid : BorderStyle.none,
                    color: Theme.of(context).accentColor)),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color:
                    isSelected ? Colors.white : Theme.of(context).accentColor,
              ),
            ),
            onPressed: () {
              setState(() {
                if (btn == "bt1") {
                  isbt1 = !isSelected;
                  sortVal = 'relevancy';
                  if (isSelected == false) {
                    isbt2 = isSelected;
                    isbt3 = isSelected;
                  }
                } else if (btn == "bt2") {
                  isbt2 = !isSelected;
                  sortVal = 'popularity';
                  if (isSelected == false) {
                    isbt1 = isSelected;
                    isbt3 = isSelected;
                  }
                } else if (btn == "bt3") {
                  isbt3 = !isSelected;
                  sortVal = 'publishedAt';
                  if (isSelected == false) {
                    isbt2 = isSelected;
                    isbt1 = isSelected;
                  }
                }
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            //------------------------------ Search Bar ----------------------------//
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onSubmitted: (value) {
                  query = value;
                },
                autofocus: true,
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
            //--------------------Date Picking -----------------------//
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(children: [
                      Icon(Icons.calendar_today),
                      Text("Date From : ",
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: 'Pacifico')),
                      SizedBox(width: 10.0),
                      Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico'),
                      ),
                    ]),
                  ),
                  RaisedButton(
                    onPressed: () => _selectDate(context),
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
            //---------------------------- Sort By Buttons ------------------//
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, top: 20.0, bottom: 20.0),
              child: Column(children: [
                Row(
                  children: [
                    Icon(LineAwesomeIcons.filter),
                    Text("Sort By : ",
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: 'Pacifico')),
                  ],
                ),
                Row(children: [
                  availableSort('Relevancy', btn: 'bt1'),
                  availableSort('Popularity', btn: 'bt2'),
                  availableSort('Published At', btn: 'bt3'),
                ]),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left:40.0, right:40.0),
              child: MaterialButton(
                  onPressed: () {},
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
    );
  }
}

class LineAwesomeIcon {}
