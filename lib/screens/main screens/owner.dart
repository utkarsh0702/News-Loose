import 'package:NewsLoose/helper/article.dart';
import 'package:NewsLoose/helper/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'personal_article_page.dart';

class Owner extends StatefulWidget {
  @override
  _OwnerState createState() => _OwnerState();
}

class _OwnerState extends State<Owner> {
  List<PersonalArticle> article = List<PersonalArticle>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    PersonalNews news = PersonalNews();
    await news.getPersonalNews();
    article = news.news;
    if (article.isEmpty) {
      _showDialog('Error',
          'Seems like some kind of error. Press the button to fix it...');
    }
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  _showDialog(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Phoenix.rebirth(context);
                },
                child: Text('Ok'),
              )
            ],
          );
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
            Spacer(
              flex: 1,
            ),
            Text(
              'News ',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Loose',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                  controller: ScrollController(keepScrollOffset: true),
                  itemCount: article.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    //------------------------ handling image exception-----------//
                    try {
                      Image.network(article[index].image_url);
                      return BlogTile(
                        imageUrl: article[index].image_url,
                        title: article[index].title,
                        content: article[index].content,
                        date: article[index].date,
                        imageCheck: false,
                      );
                    } on Exception catch (_) {
                      return BlogTile(
                        imageUrl: "assets/images/not_found.png",
                        title: article[index].title,
                        content: article[index].content,
                        date: article[index].date,
                        imageCheck: true,
                      );
                    }
                  }),
            )),
    );
  }
}

//-------------------------------- Home Screen Tiles ---------------------------//
// ignore: must_be_immutable
class BlogTile extends StatelessWidget {
  BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.content,
    @required this.date,
    @required this.imageCheck,
  });

  String imageUrl, title, content, date;
  bool imageCheck;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonalArticlePage(
                      imageUrl: imageUrl,
                      title: title,
                      content: content,
                      date: date,
                      imageCheck: imageCheck,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10.0,
          child: Container(
              child: Column(
            children: [
              (imageCheck == true)
                  ? AssetImage(imageUrl)
                  : Image.network(imageUrl),
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      date,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
