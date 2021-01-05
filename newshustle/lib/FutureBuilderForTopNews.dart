import 'package:flutter/material.dart';
import 'Networking.dart';
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
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  splashColor: Colors.red[100],
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Description()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: snapshot.data[index].urltoIMage == null
                                  ? NetworkImage(
                                      'https://th.bing.com/th/id/OIP.IPdQITB523qzc6uQR6rgGgHaE8?w=261&h=180&c=7&o=5&pid=1.7',
                                    )
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
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
