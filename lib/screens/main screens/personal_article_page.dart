import 'package:flutter/material.dart';

class PersonalArticlePage extends StatefulWidget {

  final String imageUrl, title, content, date;
  final bool imageCheck;
  PersonalArticlePage({this.imageUrl, this.title, this.content, this.date, this.imageCheck});

  @override
  _PersonalArticlePageState createState() => _PersonalArticlePageState();
}

class _PersonalArticlePageState extends State<PersonalArticlePage> {
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
      body: ListView(
        children: [
          Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
                ),
              ),
          (widget.imageCheck == true)
                  ? AssetImage(widget.imageUrl)
                  : Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Image.network(widget.imageUrl),
                  ),
          Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Date Posted: '+ widget.date,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.grey),
                ),
              ),
          Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right:20.0, bottom:20.0),
                child: Text(
                  widget.content,
                  style: TextStyle(fontSize: 19.0),
                ),
              ),
        ],
      ),
    );
  }
}