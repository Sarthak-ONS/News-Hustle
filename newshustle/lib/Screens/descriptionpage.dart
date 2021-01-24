import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final String title;
  final String author;
  final String url;
  final String urlImage;
  final String date;
  final String description;
  final int index;
  Description(this.title, this.author, this.url, this.urlImage, this.date,
      this.description, this.index);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: '${widget.index}',
                  child: Image.network(
                    widget.urlImage,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(
                            widget.author == null ? 'Unknown' : widget.author,
                            style: TextStyle(fontSize: 12.0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.date_range),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.date,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.short_text,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text('Open in Web View'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
