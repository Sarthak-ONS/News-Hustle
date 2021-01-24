import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './Screens/FilteredTab.dart';

class Technology extends StatefulWidget {
  @override
  _TechnologyState createState() => _TechnologyState();
}

const img =
    "https://th.bing.com/th/id/OIP.IPdQITB523qzc6uQR6rgGgHaE8?w=261&h=180&c=7&o=5&pid=1.7";

class _TechnologyState extends State<Technology> {
  CollectionReference users = FirebaseFirestore.instance.collection('Category');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }

          return GridView(
            scrollDirection: Axis.vertical,
            dragStartBehavior: DragStartBehavior.down,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
            // ignore: deprecated_member_use
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return GestureDetector(
                onTap: () {
                  print(document.data()['category']);
                  print(document.data()['id']);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (contetx) =>
                          ListViewForFiltered(document.data()['id'])));
                },
                child: Container(
                  height: 80,
                  width: 80,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.red,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(document.data()['photourl']),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      document.data()['category'],
                      style: TextStyle(
                          fontSize: 22,
                          shadows: [
                            BoxShadow(
                              color: Colors.blue,
                              blurRadius: 10.0,
                              spreadRadius: 20.0,
                            ),
                          ],
                          color: Colors.white),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
