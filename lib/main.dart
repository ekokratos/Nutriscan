import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DetailScreen.dart';
import 'mainPage.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController_1 = TextEditingController();
  final myController_2 = TextEditingController();
  final myController_3 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController_1.dispose();
    myController_2.dispose();
    myController_3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(
                left: 10.0, top: 10.0, right: 10.0, bottom: 5.0),
            alignment: Alignment.topLeft,
            child: Text("Please enter your Information!",
                style: TextStyle(fontSize: 30)),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 10.0, top: 0.0, right: 10.0, bottom: 10.0),
            padding: EdgeInsets.only(
                left: 10.0, top: 0.0, right: 10.0, bottom: 10.0),
            alignment: Alignment.topLeft,
            child: Text(
                "This will be used in planning your diets, your exercises and helping you get more fit",
                style: TextStyle(fontSize: 15)),
          ),
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.cake),
            title: new TextField(
              controller: myController_3,
              decoration: new InputDecoration(
                hintText: "Age",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.accessibility),
            title: new TextField(
              controller: myController_1,
              decoration: new InputDecoration(
                hintText: "Height",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.pets),
            title: new TextField(
              controller: myController_2,
              decoration: new InputDecoration(
                hintText: "Weight(Current)",
              ),
            ),
          ),
          SizedBox(height: 35),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('details').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              final record = Record.fromSnapshot(snapshot.data.documents[0]);
              return Container(
                margin: EdgeInsets.fromLTRB(120.0, 0.0, 120.0, 0.0),
                child: RaisedButton(
                  color: Colors.orangeAccent,
                  child: new Text(
                    "Submit",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Firestore.instance.runTransaction((transaction) async {
                      DocumentSnapshot freshSnap =
                          await transaction.get(record.reference);
                      await transaction.update((freshSnap.reference), {
                        'caloriesAllowed': 864 -
                            10 * int.parse(myController_3.text) +
                            (14 * int.parse(myController_2.text) +
                                503 * int.parse(myController_1.text)),
                        'height': int.parse(myController_1.text),
                        'weight': int.parse(myController_2.text),
                        'currentCalories': 0,
                      });
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
