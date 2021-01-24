import 'package:flutter/material.dart';

import 'package:newshustle/Services/Networking.dart';
import 'package:newshustle/Providers/providerclass.dart';
import 'package:provider/provider.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

import 'descriptionpage.dart';

class Coronameter extends StatefulWidget {
  @override
  _CoronameterState createState() => _CoronameterState();
}

class _CoronameterState extends State<Coronameter> {
  NewsGetter newsGetter = new NewsGetter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: newsGetter.getNews(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ImplicitlyAnimatedList(
            items: news,
            itemBuilder: (BuildContext context, Animation a, item, int index) {
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
                                  image: NetworkImage(
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
            areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
          );
        }
      },
    );
  }
}
