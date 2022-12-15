import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news.dart';

class RemoteService {
  Future<News?> getNews() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=apple&from=2022-11-21&to=2022-11-21&sortBy=popularity&apiKey=c410939489e14b028b2547229daab7cf');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return News.fromJson(data);
      // var articles = data['articles'];
      // print(articles);
    } else {
      return null;
    }
  }
}
