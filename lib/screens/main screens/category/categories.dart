import 'package:flutter/material.dart';

import 'category_page.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  List<String> images=[
    'assets/images/business.png',
    'assets/images/entertainment.jpg',
    'assets/images/general.jpg',
    'assets/images/health.jpg',
    'assets/images/science.jpg',
    'assets/images/sports.jpg',
    'assets/images/technology.jpg'
  ];

  List<String> names=[
    'Business','Entertainment','General','Health','Science','Sports','Technology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                      fontFamily: 'Langar',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ListView(
              children: List.generate(7, (index) => CategoriesLayout(
                    imageUrl : images[index], 
                    categoryName : names[index]
                  )),
            ),
          ),
        ],
      ),
    ));
  }
}


//-------------------- Category Class ---------------------------//
class CategoriesLayout extends StatelessWidget {

  final String imageUrl;
  final String categoryName;

  CategoriesLayout({ this.imageUrl,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryPage(
            category: categoryName.toLowerCase(),
          )
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(right : 20.0, left : 20.0),
        child: Container(
            margin: EdgeInsets.only(top: 15,bottom: 5),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: Offset(2,2)
                        )],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black45,
                  ),
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 35,
                      letterSpacing: 1,
                      fontFamily: 'Langar',
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
