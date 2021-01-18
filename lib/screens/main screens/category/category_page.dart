import 'package:NewsLoose/helper/article.dart';
import 'package:NewsLoose/screens/main%20screens/article_page.dart';
import 'package:flutter/material.dart';
import 'package:NewsLoose/helper/news.dart';

class CategoryPage extends StatefulWidget {

final String category;
CategoryPage({this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

List<Article> article= List<Article>();
bool _loading= true;

@override
void initState() { 
  super.initState();
  getCategoryNews();
}

getCategoryNews() async{
  CategoryNews news= CategoryNews();
  await news.getCategoryNews(widget.category);
  article= news.news;
  setState(() {
    _loading = false;
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
          child:Container(
            padding: EdgeInsets.only(top: 20.0),
            child: ListView.builder(
              controller: ScrollController(keepScrollOffset: true),
              itemCount: article.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return BlogTile(
                  imageUrl: article[index].url_to_image,
                  title: article[index].title,
                  desc: article[index].description,
                  url: article[index].url,
                );
              }
              ),
          )
          ),
        )
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
