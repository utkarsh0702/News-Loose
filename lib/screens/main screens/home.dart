import 'package:NewsLoose/helper/article.dart';
import 'package:NewsLoose/helper/news.dart';
import 'category/category_page.dart';
import 'package:flutter/material.dart';
import 'article_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

//------------------------------------ Horizontal Category Tile Slider ---------------------------
  Widget categoryContainer(String image, String name){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryPage(
            category: name.toLowerCase(),
          )
        ));
      },
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
              child: FittedBox(
                fit: BoxFit.fitWidth,
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
      ),
    );
  }

@override
void initState() { 
  super.initState();
  getNews();
}

//--------------------Tile Articles------------------------//
List<Article> article= List<Article>();
bool _loading= true;

getNews() async{
  News news= News();
  await news.getNews();
  article= news.news;
  setState(() {
    _loading = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
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
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) :
       SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(7, (index) => categoryContainer(
                    images[index], names[index]
                  )),
                ),
              ),
              //Blogs
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  controller: ScrollController(keepScrollOffset: true),
                  itemCount: article.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    try{
                      Image.network(article[index].url_to_image);
                    } on Exception catch (_) {
                        article.remove(index);
                      }
                    return BlogTile(
                      imageUrl: article[index].url_to_image,
                      title: article[index].title,
                      desc: article[index].description,
                      url: article[index].url,
                    );
                  }
                  ),
              )
            ],
          ),
        )
        ),
    );
  }
}

//-------------------------------- Home Screen Tiles ---------------------------//
// ignore: must_be_immutable
class BlogTile extends StatelessWidget {

  BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.url,
  });

  String imageUrl, title, desc, url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticlePage(
            blogUrl: url,
          )
          ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10.0,
          child: Container(
            child:Column(
              children: [
                Image.network(imageUrl),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0, right:8.0, bottom:8.0),
                  child: Text(desc,
                  style: TextStyle(
                      fontSize: 15.0
                    ),
                  ),
                )
              ],
              )
          ),
        ),
      ),
    );
  }
}
