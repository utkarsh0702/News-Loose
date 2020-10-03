import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> images=[
    'assets/images/national.jpg',
    'assets/images/world.jpg',
    'assets/images/nature.jpg',
    'assets/images/sports.jpg',
    'assets/images/covid.jpg',
    'assets/images/entertainment.jpg'
  ];

  List<String> names=[
    'National', 'World', 'Nature', 'Sports', 'COVID', 'Entertainment'
  ];

//------------------------------------ Horizontal Category Slider ---------------------------
  Widget categoryContainer(String image, String name){
    return GestureDetector(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.only(top:10.0, bottom:10.0, left:5.0, right: 5.0),
        child: Card(
          elevation: 10.0,
          color: Colors.transparent,
          child: Container(
            height: 60.0,
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken)
                )
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//-------------------------------- Home Screen Tiles ---------------------------
Widget tile(String image, String title, String desc){
  return Container(
    child: Column(
      children: [
        Image.asset(image),
        Text(
          title
        ),
        Text(
          desc
        )
      ],
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
            Spacer(flex: 1,),
            Text(
              'News',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'Loose',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold
              ),
            ),
            Spacer(flex: 2,)
          ],
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(6, (index) => categoryContainer(
                  images[index], names[index]
                )),
              ),
            )
          ],
        )
        ),
    );
  }
}