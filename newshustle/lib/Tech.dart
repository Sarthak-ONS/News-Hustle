import 'package:flutter/material.dart';

class Technology extends StatefulWidget {
  @override
  _TechnologyState createState() => _TechnologyState();
}

const img =
    "https://th.bing.com/th/id/OIP.IPdQITB523qzc6uQR6rgGgHaE8?w=261&h=180&c=7&o=5&pid=1.7";

class _TechnologyState extends State<Technology> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, indec) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.00),
                  child: Container(
                    height: 260,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(img))),
                  ),
                ),
                ExpansionTile(
                  maintainState: true,
                  trailing: Icon(Icons.add),
                  title: Text('Here is the title of the News'),
                  subtitle: Text('Here comes the Subttile'),
                  backgroundColor: Colors.white,
                  children: [
                    Text('Description'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Colors.blue[400],
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('View'),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class TextForNewsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hellozvjvbuiadnvuadibvsadubovvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv'
                  .substring(0, 25),
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Hellozvjvbuiadnvuadibvsadubovvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv',
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
            )
          ],
        ),
      ),
    );
  }
}
