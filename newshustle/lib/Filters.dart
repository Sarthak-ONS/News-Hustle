import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providerclass.dart';
import 'Networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  String _selectedCountry;
  String _selectedCategory;

  @override
  void dispose() {
    NewsGetter news = new NewsGetter();
    news.getNews();
    super.dispose();
  }

  changecountrycategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedCountry = prefs.get("Country");
    _selectedCategory = prefs.get("Category");
    setState(() {});
  }

  @override
  void initState() {
    changecountrycategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Country And Language',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select A country',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  child: DropdownButton(
                    dropdownColor: Colors.grey[100],
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    icon: Icon(Icons.add),
                    elevation: 20,
                    value: _selectedCountry,
                    items: [
                      DropdownMenuItem(
                        child: Text('Australia'),
                        value: 'au',
                      ),
                      DropdownMenuItem(
                        child: Text('Austria'),
                        value: 'ae',
                      ),
                      DropdownMenuItem(
                        child: Text('Indonesia'),
                        value: 'id',
                      ),
                      DropdownMenuItem(
                        child: Text('India'),
                        value: 'in',
                      ),
                      DropdownMenuItem(
                        child: Text('United Arab Emirates'),
                        value: 'ua',
                      ),
                      DropdownMenuItem(
                        child: Text('United States'),
                        value: 'us',
                      ),
                    ],
                    onChanged: _callbackforCountry,
                  ),
                  padding: EdgeInsets.only(left: 18),
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Default Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  child: DropdownButton(
                    value: _selectedCategory,
                    dropdownColor: Colors.grey[100],
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    icon: Icon(Icons.add),
                    elevation: 20,

                    //value: 'au',
                    items: [
                      DropdownMenuItem(
                        child: Text('Business'),
                        value: 'business',
                      ),
                      DropdownMenuItem(
                        child: Text('Sports'),
                        value: 'sports',
                      ),
                      DropdownMenuItem(
                        child: Text('Technology'),
                        value: 'technology',
                      ),
                      DropdownMenuItem(
                        child: Text('Science'),
                        value: 'Science',
                      ),
                      DropdownMenuItem(
                        child: Text('Health'),
                        value: 'health',
                      ),
                      DropdownMenuItem(
                        child: Text('Entertainment'),
                        value: 'entertainment',
                      ),
                    ],
                    onChanged: _callbackforCategory,
                  ),
                  padding: EdgeInsets.only(left: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _callbackforCountry(value) {
    Provider.of<AppData>(context, listen: false).changeDefaultCountry(value);
    Provider.of<AppData>(context, listen: false).storeinLocalStorage();
    setState(() {
      _selectedCountry = value;
    });
    print(value);
  }

  void _callbackforCategory(value) {
    Provider.of<AppData>(context, listen: false).changeDefaultCategory(value);
    Provider.of<AppData>(context, listen: false).storeinLocalStorage();
    setState(() {
      _selectedCategory = value;
    });
    print(value);
  }
}
