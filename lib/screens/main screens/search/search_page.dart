import 'package:NewsLoose/helper/article.dart';
import 'package:NewsLoose/screens/main%20screens/article_page.dart';
import 'package:flutter/material.dart';
import 'package:NewsLoose/helper/news.dart';

class SearchPage extends StatefulWidget {

  final String query, source, sort, fromdate, todate;
 SearchPage({this.query, this.fromdate, this.todate, this.source, this.sort});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Article> article= List<Article>();
bool _loading= true;

@override
void initState() { 
  super.initState();
  getSearchNews();
}

getSearchNews() async{
  SearchNews news= SearchNews();
  await news.getSearchNews(widget.query, widget.fromdate, widget.todate, widget.source, widget.sort);
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
              'News ',
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
      ) : (article.isEmpty ? Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                Icon(Icons.error_outline, size:30.0, color:Colors.grey),
                Text('No Results', style:TextStyle(fontSize:30.0, color:Colors.grey))
              ])
          ],),
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
      )
    );
  }
}

//-------------------------------- Search Page Tiles ---------------------------//
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