import 'package:flutter/material.dart';
import 'package:NewsLoose/helper/image_lookup.dart';

class ChangeAvatar extends StatefulWidget {
  @override
  _ChangeAvatarState createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends State<ChangeAvatar> {
  bool tick1 = false,
      tick2 = false,
      tick3 = false,
      tick4 = false,
      tick5 = false;
  bool tick6 = false, tick7 = false, tick8 = false, tick9 = false;
  int number=1;

  Widget imageContainer(int number) {
    bool tick=false;
    switch(number){
            case 1: tick=tick1; break;
            case 2: tick=tick2; break;
            case 3: tick=tick3; break;
            case 4: tick=tick4; break;
            case 5: tick=tick5; break;
            case 6: tick=tick6; break;
            case 7: tick=tick7; break;
            case 8: tick=tick8; break;
            case 9: tick=tick9; break;
          }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            switch(number){
            case 1: tick1=true; tick2=tick3=tick4=tick5=tick6=tick7=tick8=tick9=false; break;
            case 2: tick2=true; tick1=tick3=tick4=tick5=tick6=tick7=tick8=tick9=false; break;
            case 3: tick3=true; tick2=tick1=tick4=tick5=tick6=tick7=tick8=tick9=false; break;
            case 4: tick4=true; tick2=tick3=tick1=tick5=tick6=tick7=tick8=tick9=false; break;
            case 5: tick5=true; tick2=tick3=tick4=tick1=tick6=tick7=tick8=tick9=false; break;
            case 6: tick6=true; tick2=tick3=tick4=tick5=tick1=tick7=tick8=tick9=false; break;
            case 7: tick7=true; tick2=tick3=tick4=tick5=tick6=tick1=tick8=tick9=false; break;
            case 8: tick8=true; tick2=tick3=tick4=tick5=tick6=tick7=tick1=tick9=false; break;
            case 9: tick9=true; tick2=tick3=tick4=tick5=tick6=tick7=tick8=tick1=false; break;
          }
          });
        },
        child: Container(
            height: 100.0,
            width: 100.0,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).accentColor, width: 5),
                image: DecorationImage(
                  image: AssetImage(imageLookUp(number)),
                  colorFilter: tick?
                      ColorFilter.mode(Colors.black54, BlendMode.darken):null,
                  fit: BoxFit.contain,
                )),
            child: tick? Icon(Icons.check,
                size: 30.0, color: Theme.of(context).accentColor):null
                ),
      ),
    );
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text('Change Avatar',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              imageContainer(1),
              imageContainer(2),
              imageContainer(3),
              imageContainer(4),
              imageContainer(5),
              imageContainer(6),
              imageContainer(7),
              imageContainer(8),
              imageContainer(9),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: MaterialButton(
                  onPressed: () {
                    if(tick1==true){number=1;}
                    else if(tick2==true){number=2;}
                    else if(tick3==true){number=3;}
                    else if(tick4==true){number=4;}
                    else if(tick5==true){number=5;}
                    else if(tick6==true){number=6;}
                    else if(tick7==true){number=7;}
                    else if(tick8==true){number=8;}
                    else if(tick9==true){number=9;}

                    Navigator.pop(context,number);
                  },
                  color: Theme.of(context).accentColor,
                  splashColor: Theme.of(context).primaryColor,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
