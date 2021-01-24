import 'package:flutter/material.dart';
import '../Services/Networking.dart';
import 'descriptionpage.dart';
import 'package:provider/provider.dart';
import '../Providers/providerclass.dart';

class FutureBuilderForTopNews extends StatelessWidget {
  const FutureBuilderForTopNews({
    Key key,
    @required this.newsGetter,
    @required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);

  final NewsGetter newsGetter;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: newsGetter.getNews(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            controller: _scrollController,
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
                                  image: snapshot.data[index].urltoIMage == null
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
    );
  }
}
