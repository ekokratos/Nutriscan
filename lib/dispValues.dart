import 'package:flutter/material.dart';
import 'getcal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DetailScreen.dart';
import 'mainPage.dart';

class DispValues extends StatelessWidget {
  Information udata;

  DispValues({Key key, @required this.udata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: new Stack(
          children: <Widget>[
            Center(
              child: new Image.asset(
                'assets/background.png',
                width: 400,
                height: 1000,
                fit: BoxFit.fill,
              ),
            ),
            new Positioned(
              left: 150,
              top: 70,
              child: Center(
                child: Text(udata.fName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontStyle: FontStyle.italic)),
              ),
            ),
            new Positioned(
              left: 30,
              top: 300,
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green[200]),
                child: Center(
                  child: Text("Calories:" + udata.calo + "\n",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
            ),
            new Positioned(
              right: 30,
              top: 200,
              child: Container(
                height: 150,
                width: 150,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.lime[200]),
                child: Center(
                  child: Text("Fat: " + udata.fat + "\n",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('details').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                final record = Record.fromSnapshot(snapshot.data.documents[0]);
                return Positioned(
                  left: 60,
                  bottom: 30,
                  child: Container(
                    height: 80,
                    width: 80,
                    child: new FloatingActionButton(
                      heroTag: "right",
                      backgroundColor: Colors.lightGreenAccent,
                      child: Icon(Icons.done),
                      onPressed: () => {
                            Firestore.instance
                                .runTransaction((transaction) async {
                              DocumentSnapshot freshSnap =
                                  await transaction.get(record.reference);
                              await transaction.update((freshSnap.reference), {
                                'currentCalories':
                                    freshSnap['currentCalories'] +
                                        double.parse(udata.calo).toInt(),
                              });
                            }),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ),
                            ),
                          },
                    ),
                  ),
                );
              },
            ),
            new Positioned(
              right: 60,
              bottom: 30,
              child: Container(
                height: 80,
                width: 80,
                child: new FloatingActionButton(
                  heroTag: "wrong",
                  backgroundColor: Colors.redAccent,
                  child: Icon(
                    Icons.clear,
                  ),
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ),
                        )
                      },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
