import 'package:flutter/material.dart';
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
class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final res = ll.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemCount: res.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.location_city),
          title: Text(res[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: recent.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.location_city),
          title: Text(recent[index]),
        );
      },
    );
  }
}
