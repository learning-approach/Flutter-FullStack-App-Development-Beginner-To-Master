import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/services/remote_service.dart';
import 'package:news_app/views/news_details.dart';

class NewsHome extends StatefulWidget {
  @override
  State<NewsHome> createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  News? news;
  bool isLoaded = false;

  getData() async {
    news = await RemoteService().getNews();
    if (news != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: news == null ? 0 : news!.articles!.length,
          itemBuilder: (_, index) {
            return Card(
              elevation: 2,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => NewsDetails(
                      news!.articles![index],
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      news!.articles![index].urlToImage ??
                          'https://us.123rf.com/450wm/mattbadal/mattbadal1911/mattbadal191100006/mattbadal191100006.jpg?ver=6',
                      height: 140,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 5,
                        left: 8,
                      ),
                      child: Text(
                        news!.articles![index].title ?? 'Null',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 5,
                        left: 8,
                      ),
                      child: Text(
                        news!.articles![index].author ?? 'Null',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 15,
                        left: 8,
                      ),
                      child: Text(
                        news!.articles![index].publishedAt ?? 'Nothing',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
