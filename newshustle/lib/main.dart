import 'package:newshustle/Screens/AuthScreen.dart';
import 'package:newshustle/Services/AuthService.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Models/FirebaeNotification.dart';
import 'Screens/CoronaVirusTab.dart';
import 'Services/Networking.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Providers/providerclass.dart';
import 'Screens/FutureBuilderForTopNews.dart';
import 'Screens/Filters.dart';
import 'FilteredCategory.dart';
//GqQieIHrZ5b3NQTQTp8UcTVjm4I3

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      create: (context) => AppData(),
      child: UnderLyingProvider(),
    );
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
  MyHomePage({@required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Fcm> messages = [];
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
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        final notification = message['notification'];
        setState(() {
          messages.add(Fcm(notification['title'], notification['body']));
        });
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _scrollController = ScrollController();
    _tabController = TabController(length: _tabList.length, vsync: this);
    Provider.of<AppData>(context, listen: false).storeinLocalStorage();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Auth auth = Auth();

  Future showSignout() async {}

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
                // print(Provider.of<AppData>(context, listen: false).somedata);

                print(FirebaseAuth.instance.currentUser.uid);
              },
              leading: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
              title: Text(
                'BookMark',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: Divider(
                thickness: 2,
                color: Colors.black45,
              ),
            ),
            ListTile(
              leading: IconButton(
                  icon: Icon(
                    Icons.category,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
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
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: Divider(
                thickness: 2,
                color: Colors.black45,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Filters()));
              },
              leading: IconButton(
                  icon: Icon(
                    Icons.filter,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
              title: Text('Filters'),
            ),
            //showSignout(),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: Divider(
                thickness: 2,
                color: Colors.black45,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthScreen()));
              },
              leading: IconButton(
                  icon: Icon(
                    Icons.filter,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
              title: Text('Become A User'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: Divider(
                thickness: 2,
                color: Colors.black54,
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
              child: Coronameter(),
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
        onPressed: () async {
          print('Hey ');
          //GqQieIHrZ5b3NQTQTp8UcTVjm4I3
          print(FirebaseAuth.instance.currentUser.uid);
          print("GqQieIHrZ5b3NQTQTp8UcTVjm4I3");
        },
        tooltip: 'Increment',
      ),
    );
  }
}
