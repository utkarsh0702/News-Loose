import 'dart:convert';
import 'article.dart';
import 'package:http/http.dart' as http;

class News{
  List<Article> news = [];

  Future<void> getNews() async{

    String url= 'https://newsapi.org/v2/top-headlines?country=in&apiKey=9c32b0a65fd64b97bc82924563afd873';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article= Article(
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
  }
}

class CategoryNews{
  List<Article> news = [];

  Future<void> getCategoryNews(String category) async{

    String url= 'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=9c32b0a65fd64b97bc82924563afd873';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article= Article(
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
  }
}

class SearchNews{
  List<Article> news = [];

  Future<void> getSearchNews(String query, String fromdate, String todate, String source, String sort) async{

    String url='';
    if(query.isEmpty){
      if(source == 'all'){
        url= 'https://newsapi.org/v2/everything?from=$fromdate&to=$todate&sortBy=$sort&apiKey=9c32b0a65fd64b97bc82924563afd873';
      }
      else{
        url= 'https://newsapi.org/v2/everything?from=$fromdate&to=$todate&sources=$source&sortBy=$sort&apiKey=9c32b0a65fd64b97bc82924563afd873';
      }
    }
    else{
      if(source == 'all'){
        url= 'https://newsapi.org/v2/everything?q=$query&from=$fromdate&to=$todate&sortBy=$sort&apiKey=9c32b0a65fd64b97bc82924563afd873';
      }
      else{
        url= 'https://newsapi.org/v2/everything?q=$query&from=$fromdate&to=$todate&sources=$source&sortBy=$sort&apiKey=9c32b0a65fd64b97bc82924563afd873';
      }
    }
    

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article= Article(
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
  }
}