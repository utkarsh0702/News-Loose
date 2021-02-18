import 'dart:convert';
import 'article.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class News {
  List<Article> news = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  String con = 'in';

  assignValues() async {
    FirebaseUser user = await auth.currentUser();
    await Firestore.instance
        .collection('User Data')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot ds) {
      con = ds['Country'];
    });
  }

  Future<void> getNews() async {
    await assignValues();

    String url =
        'https://newsapi.org/v2/top-headlines?country=$con&apiKey=9c32b0a65fd64b97bc82924563afd873';

    try {
      var response = await http.get(url);

      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              url_to_image: element['urlToImage'],
              content: element['content'],
            );

            news.add(article);
          }
        });
      }
    } catch (_) {}
  }
}

class CategoryNews {
  List<Article> news = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  String con = 'in';

  assignValues() async {
    FirebaseUser user = await auth.currentUser();
    await Firestore.instance
        .collection('User Data')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot ds) {
      con = ds['Country'];
    });
  }

  Future<void> getCategoryNews(String category) async {
    await assignValues();

    String url =
        'https://newsapi.org/v2/top-headlines?country=$con&category=$category&apiKey=9c32b0a65fd64b97bc82924563afd873';

    try {
      var response = await http.get(url);

      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              url_to_image: element['urlToImage'],
              content: element['content'],
            );

            news.add(article);
          }
        });
      }
    } catch (_) {}
  }
}

class SearchNews {
  List<Article> news = [];

  Future<void> getSearchNews(String query, String fromdate, String todate,
      String source, String sort) async {
    String url = '';
    if (query.isEmpty) {
      if (source == 'all') {
        url =
            'https://newsapi.org/v2/everything?from=$fromdate&to=$todate&sortBy=$sort&apiKey=9c32b0a65fd64b97bc82924563afd873';
      } else {
        url =
            'https://newsapi.org/v2/everything?from=$fromdate&to=$todate&sources=$source&sortBy=$sort&apiKey=9c32b0a65fd64b97bc82924563afd873';
      }
    } else {
      if (source == 'all') {
        url =
            'https://newsapi.org/v2/everything?q=$query&from=$fromdate&to=$todate&sortBy=$sort&apiKey=9c32b0a65fd64b97bc82924563afd873';
      } else {
        url =
            'https://newsapi.org/v2/everything?q=$query&from=$fromdate&to=$todate&sources=$source&sortBy=$sort&apiKey=9c32b0a65fd64b97bc82924563afd873';
      }
    }

    try {
      var response = await http.get(url);

      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              url_to_image: element['urlToImage'],
              content: element['content'],
            );

            news.add(article);
          }
        });
      }
    } catch (_) {}
  }
}

class PersonalNews {
  List<PersonalArticle> news = [];

  Future<void> getPersonalNews() async {
    String url = 'https://utkarsh.pythonanywhere.com/?format=json';

    var response = await http.get(url);

    try {
      var jsonData = jsonDecode(response.body);

      jsonData.forEach((element) {
        PersonalArticle article = PersonalArticle(
          title: element["title"],
          image_url: element['image_url'],
          content: element['content'],
          date: element['date'],
        );
        news.add(article);
      });
    } catch (_) {}
  }
}
