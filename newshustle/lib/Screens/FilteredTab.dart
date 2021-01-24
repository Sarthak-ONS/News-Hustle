import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newshustle/Providers/providerclass.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'FutureBuilderForTopNews.dart';
import '../Models/NewsModel.dart';
import 'package:flutter/material.dart';

import 'descriptionpage.dart';

List<NewsData> filterednews = [];

class ListViewForFiltered extends StatefulWidget {
  final String category;

  const ListViewForFiltered(this.category);

  @override
  _ListViewForFilteredState createState() => _ListViewForFilteredState();
}

class _ListViewForFilteredState extends State<ListViewForFiltered> {
  Future<List<NewsData>> getNews() async {
    try {
      var category = widget.category;
      print(category);

      var url =
          "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=27421b8e03c54d4f9f18b581d04f1709";
      var response = await http.get(url);
      var decoded = jsonDecode(response.body);
      var loopOver = decoded['articles'];
      print(loopOver);
      for (var item in loopOver) {
        NewsData n = NewsData(item['url'], item['urlToImage'], item['title'],
            item['publishedAt'], item['author'], item['content']);

        filterednews.add(n);
      }
      //print(news[0].description);
      return filterednews;
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered'),
      ),
      body: FutureBuilder(
        future: getNews(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Hero(
                                tag: '$index',
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  width: 80,
                                  height: 80.0,
                                  child: FadeInImage(
                                    fadeInCurve: Curves.bounceOut,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        AssetImage('images/dribbble.gif'),
                                    image:
                                        snapshot.data[index].urltoIMage == null
                                            ? AssetImage('images/dribbble.gif')
                                            : NetworkImage(
                                                snapshot.data[index].urltoIMage,
                                              ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index].title == null
                                          ? 'Unknown'
                                          : snapshot.data[index].title,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data[index].author == null
                                                ? 'Unknown'
                                                : snapshot.data[index].author,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  childrenPadding: EdgeInsets.all(8.0),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Date : ${snapshot.data[index].date}'
                                      .substring(0, 17),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Time : ${snapshot.data[index].date}'
                                      .substring(17),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          color: Provider.of<AppData>(context).isDark
                              ? Colors.red[600]
                              : Colors.blue[600],
                          onPressed: () {
                            // print(snapshot.data[index].url);
                            print(snapshot.data[index].description);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Description(
                                    snapshot.data[index].title,
                                    snapshot.data[index].author,
                                    snapshot.data[index].url,
                                    snapshot.data[index].urltoIMage,
                                    snapshot.data[index].date,
                                    snapshot.data[index].description,
                                    index),
                              ),
                            );
                          },
                          child: Text(
                            'View Article',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
