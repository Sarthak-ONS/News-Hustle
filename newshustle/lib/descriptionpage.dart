import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            title: Text('Top News'),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  "https://th.bing.com/th/id/OIP.IPdQITB523qzc6uQR6rgGgHaE8?w=261&h=180&c=7&o=5&pid=1.7"),
            ),
          ),
        ],
      ),
    );
  }
}
