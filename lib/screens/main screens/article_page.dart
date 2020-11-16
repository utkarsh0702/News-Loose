import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {

  final String blogUrl;
  ArticlePage({this.blogUrl});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  final Completer<WebViewController> _controller= Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex:1),
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
            Spacer(flex:2),
          ],
        ),
        elevation: 0.0,
      ),
      body:Container(
        width: size.width,
        height: size.height,
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _controller.complete(webViewController);
          }),
        ),
      ),
    );
  }
}