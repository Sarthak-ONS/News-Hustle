import 'Networking.dart';
import 'package:flutter/material.dart';
import 'SearchDelegate.dart';
import 'NewsModel.dart';

List<NewsData> news = [];

List<String> ll = [
  "New Delhi",
  "Chennai",
  "Banglore",
  "Lucknow",
  "Goa",
  "Mawsynram",
  "Bareilly",
  "Ghaziabad",
  "Merut",
  "Gandhinagar"
];

List<String> recent = ["New Delhi", "Chennai", "Banglore"];

const url =
    "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=27421b8e03c54d4f9f18b581d04f1709";
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'News',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  NewsGetter newsGetter = NewsGetter();
  int _counter = 0;

  List<Tab> _tabList = [
    Tab(
      child: Text('Top'),
    ),
    Tab(
      child: Text('Popular'),
    ),
    Tab(
      child: Text('Trending'),
    ),
    Tab(
      child: Text('Editor Choice'),
    ),
    Tab(
      child: Text('Coronvirus'),
    ),
  ];

  TabController _tabController;

  Future<void> _incrementCounter() async {
    print(news);
    setState(
      () {
        _counter++;
      },
    );
  }

  // Future<List<NewsData>> getNews() async {
  //   var response = await http.get(url);
  //   var decoded = jsonDecode(response.body);
  //   var loopOver = decoded['articles'];
  //   print(loopOver.length);
  //   for (var item in loopOver) {
  //     NewsData n = NewsData(item['url'], item['urlToImage'], item['title'],
  //         item['publishedAt'], item['author']);
  //     news.add(n);
  //   }
  //   return news;
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: _tabList,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text(
                'News',
                style: TextStyle(fontSize: 24),
              ),
            ),
            ListTile(
              leading: IconButton(icon: Icon(Icons.add), onPressed: () {}),
              title: Text('BookMark'),
            ),
            ListTile(
              leading: IconButton(icon: Icon(Icons.category), onPressed: () {}),
              title: Text('BookMark'),
            ),
            ListTile(
              leading: IconButton(icon: Icon(Icons.ac_unit), onPressed: () {}),
              title: Text('BookMark'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: newsGetter.getNews(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2.0,
                        margin: EdgeInsets.only(bottom: 8.0),
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
                                    image:
                                        snapshot.data[index].urltoIMage == null
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
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
        ],
        controller: _tabController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// return ListView.builder(
//                 itemCount: news.length,
//                 itemBuilder: (context, index) {
//                   //print(news[index].title);
//                   return ListTile(
//                     leading: Icon(Icons.create_new_folder),
//                     title: Text(snapshot.data[index].title == null
//                         ? 'Unkown'
//                         : snapshot.data[index].title),
//                   );
//                 },
//               )
