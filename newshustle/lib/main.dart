import 'dart:async';

import 'package:newshustle/descriptionpage.dart';
import 'package:provider/provider.dart';

import 'Networking.dart';
import 'package:flutter/material.dart';
import 'SearchDelegate.dart';
import 'NewsModel.dart';
import 'providerclass.dart';
import 'Filters.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isDark = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppData(), child: UnderLyingProvider());
  }
}

class UnderLyingProvider extends StatefulWidget {
  @override
  _UnderLyingProviderState createState() => _UnderLyingProviderState();
}

class _UnderLyingProviderState extends State<UnderLyingProvider> {
  bool isDark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<AppData>(context).isDark
          ? ThemeData(primarySwatch: Colors.red)
          : ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(
        title: 'News Hustle',
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

  List<Tab> _tabList = [
    Tab(
      child: Text('Top'),
    ),
    Tab(
      child: Text('Tech'),
    ),
    Tab(
      child: Text('Business'),
    ),
    Tab(
      child: Text('India'),
    ),
    Tab(
      child: Text('Coronvirus'),
    ),
  ];

  TabController _tabController;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: TabBar(
            onTap: _onTap,
            indicatorSize: TabBarIndicatorSize.tab,
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
              decoration: BoxDecoration(
                  color: Provider.of<AppData>(context).isDark
                      ? Colors.red
                      : Colors.blue),
              child: Center(
                child: Text(
                  'News Hustle',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                print(Provider.of<AppData>(context, listen: false).somedata);
              },
              leading: IconButton(icon: Icon(Icons.add), onPressed: () {}),
              title: Text('BookMark'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: IconButton(icon: Icon(Icons.category), onPressed: () {}),
              title: Text(
                'Change Color Theme To Red',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              trailing: Switch(
                value: Provider.of<AppData>(context).isDark,
                onChanged: (value) {
                  Provider.of<AppData>(context, listen: false)
                      .changeTheme(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Filters()));
              },
              leading: IconButton(icon: Icon(Icons.filter), onPressed: () {}),
              title: Text('Filters'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Divider(
                thickness: 2,
              ),
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
                    controller: _scrollController,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2.0,
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: InkWell(
                          splashColor: Colors.red[100],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Description()));
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
                                      image: snapshot.data[index].urltoIMage ==
                                              null
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              snapshot.data[index].author ==
                                                      null
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
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.red, Colors.yellow])),
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
        ],
        controller: _tabController,
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        label: Row(
          children: [
            Text('Search'),
            SizedBox(width: 5),
            Icon(Icons.search),
          ],
        ),
        onPressed: () {
          print(Provider.of<AppData>(context, listen: false).isDark);
          //showSearch(context: context, delegate: DataSearch());
        },
        tooltip: 'Increment',
      ),
    );
  }

  void _onTap(int value) {
    _scrollController.animateTo(20,
        duration: Duration(microseconds: 500), curve: Curves.easeInBack);
  }
}
