import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  Map m = {"ae": "United Arab Emirates", "au": "Austrailia", "in": "India"};

  String dropdownValue = 'Au';

  List<DropdownMenuItem> l = [
    DropdownMenuItem(child: Text('Au')),
    DropdownMenuItem(child: Text('Aw')),
  ];

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
              leading: Text('Select A country'),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Hello'),
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              leading: Text('Select A Language'),
              trailing: Text('Eng'),
            ),
          ],
        ),
      ),
    );
  }
}
