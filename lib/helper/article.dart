class Article{
  String author;
  String title;
  String description;
  String url;
  // ignore: non_constant_identifier_names
  String url_to_image;
  String content;

  // ignore: non_constant_identifier_names
  Article({ this.author, this.title, this.description, this.url, this.url_to_image, this.content});
}

class PersonalArticle{
  String title;
  // ignore: non_constant_identifier_names
  String image_url;
  String content;
  String date;

  // ignore: non_constant_identifier_names
  PersonalArticle({this.title, this.image_url, this.content, this.date});
}