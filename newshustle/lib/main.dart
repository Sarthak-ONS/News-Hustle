import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Networking.dart';
import 'package:flutter/material.dart';
import 'SearchDelegate.dart';
import 'NewsModel.dart';
import 'providerclass.dart';
import 'FutureBuilderForTopNews.dart';
import 'Filters.dart';
import 'Tech.dart';

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
      child: Text('Filtered'),
    ),
    Tab(
      child: Text('CoronaVirus'),
    ),
  ];

  TabController _tabController;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _tabController = TabController(length: _tabList.length, vsync: this);
    Provider.of<AppData>(context, listen: false).storeinLocalStorage();
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
      body: RefreshIndicator(
        onRefresh: () async {
          newsGetter.getNews();
        },
        child: TabBarView(
          
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  newsGetter.getNews();
                },
                child: FutureBuilderForTopNews(
                  newsGetter: newsGetter,
                  scrollController: _scrollController,
                ),
              ),
            ),
            Technology(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(),
            ),
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
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
          print('Hey ');
        },
        tooltip: 'Increment',
      ),
    );
  }
}
